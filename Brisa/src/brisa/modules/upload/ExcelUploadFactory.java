/**
 * 
 */
package brisa.modules.upload;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * 
 * Takes a excel upload request and transforms it to a file.
 * 
 * @author Kristofer Arwidsson
 */
public class ExcelUploadFactory {

	private String fileName = null;
	private String fullName = null;
	private File file = null;

	public ExcelUploadFactory(HttpServletRequest req, HttpServletResponse res) {

		processRequest(req, res);
	}

	public void processRequest(HttpServletRequest req, HttpServletResponse res) {

		// PrintWriter to send the JSON response back
		PrintWriter out;
		try {
			out = res.getWriter();
		} catch (IOException e1) {
			resetFactory();
			return;
		}

		// set content type and header attributes
		res.setContentType("text/html");
		res.setHeader("Cache-control", "no-cache, no-store");
		res.setHeader("Pragma", "no-cache");
		res.setHeader("Expires", "-1");

		DiskFileItemFactory fileItemFactory = new DiskFileItemFactory();

		// Set the size threshold, above which content will be stored on disk.
		fileItemFactory.setSizeThreshold(1 * 1024 * 1024); // 1 MB

		// Set the temporary directory to store the uploaded files of size above
		// threshold.
		// fileItemFactory.setRepository(tmpDir);

		ServletFileUpload uploadHandler = new ServletFileUpload(fileItemFactory);

		try {

			// Parse the request
			List items = uploadHandler.parseRequest(req);
			Iterator iterator = items.iterator();

			while (iterator.hasNext()) {
				FileItem item = (FileItem) iterator.next();

				// Handle Form Fields
				if (item.isFormField()) {
					System.out.println("Field Name = " + item.getFieldName()
							+ ", Value = " + item.getString());
					if (item.getFieldName().trim().equalsIgnoreCase("filename")) {
						setFileName(item.getString().trim());
					}
				}

				// Handle Uploaded file.
				else {
					System.out.println("Field Name = " + item.getFieldName()
							+ ", File Name = " + item.getName()
							+ ", Content type = " + item.getContentType()
							+ ", File Size = " + item.getSize());

					setFullName(item.getName().trim());

					// Write file to the ultimate location.
					// file = new File(destinationDir,item.getName());

					// Just create the file..
					setFile(new File(item.getName()));
					item.write(file);

					break; // Only one file support
				}
			}
		} catch (FileUploadException ex) {
			resetFactory();
			return;
		} catch (Exception ex) {
			resetFactory();
			return;
		}

		out.close();

		return;
	}

	private void resetFactory() {
		this.setFileName(null);
		this.setFullName(null);
		this.setFile(null);

	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

}
