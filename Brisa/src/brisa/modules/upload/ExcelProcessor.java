package brisa.modules.upload;

import java.io.File;
import java.io.FileInputStream;
import java.util.Iterator;

import org.apache.commons.io.FilenameUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * 
 * 
 * 
 * @author Kristofer Arwidsson
 *
 */
public class ExcelProcessor {

	public void processFile(File file, String fullName) throws Exception {

		String extension = FilenameUtils.getExtension(fullName);
		if (extension.trim().equalsIgnoreCase("xlsx")) {
			processXlsxExcelFile(file);
		} else if (extension.trim().equalsIgnoreCase("xls")) {
			processXlsExcelFile(file);
		}

		if (extension.trim().equalsIgnoreCase("csv")) {
			// process your CSV file
		}
	}

	private void processXlsExcelFile(File file) throws Exception {

		try {
			// Creating Input Stream
			FileInputStream myInput = new FileInputStream(file);

			// Create a workbook using the File System
			HSSFWorkbook myWorkBook = new HSSFWorkbook(myInput);

			// Get the first sheet from workbook
			HSSFSheet mySheet = myWorkBook.getSheetAt(0);

			/** We now need something to iterate through the cells. **/
			Iterator<Row> rowIter = mySheet.rowIterator();
			while (rowIter.hasNext()) {

				HSSFRow myRow = (HSSFRow) rowIter.next();
				Iterator<Cell> cellIter = myRow.cellIterator();
				while (cellIter.hasNext()) {

					HSSFCell myCell = (HSSFCell) cellIter.next();
					// get cell index
					System.out.println("Cell column index: "
							+ myCell.getColumnIndex());
					// get cell type
					System.out.println("Cell Type: " + myCell.getCellType());

					// get cell value
					switch (myCell.getCellType()) {
					case HSSFCell.CELL_TYPE_NUMERIC:
						System.out.println("Cell Value: "
								+ myCell.getNumericCellValue());
						break;
					case HSSFCell.CELL_TYPE_STRING:
						System.out.println("Cell Value: "
								+ myCell.getStringCellValue());
						break;
					default:
						System.out
								.println("Couldn´t find a type for this cell!");
						break;
					}

					System.out.println("---");

				}

			}

			myWorkBook.close();
		} catch (Exception e) {
			throw new Exception("Failed to process .xls file. "
					+ e.getMessage());
		}
	}

	private void processXlsxExcelFile(File file) throws Exception {

		try {
			// Creating Input Stream
			FileInputStream myInput = new FileInputStream(file);

			// Create a workbook using the File System
			XSSFWorkbook myWorkBook = new XSSFWorkbook(myInput);

			// Get the first sheet from workbook
			XSSFSheet mySheet = myWorkBook.getSheetAt(0);

			/** We now need something to iterate through the cells. **/
			Iterator<Row> rowIter = mySheet.rowIterator();
			while (rowIter.hasNext()) {

				XSSFRow myRow = (XSSFRow) rowIter.next();
				Iterator<Cell> cellIter = myRow.cellIterator();
				while (cellIter.hasNext()) {

					XSSFCell myCell = (XSSFCell) cellIter.next();
					// get cell index
					System.out.println("Cell column index: "
							+ myCell.getColumnIndex());
					// get cell type
					System.out.println("Cell Type: " + myCell.getCellType());

					// get cell value
					switch (myCell.getCellType()) {
					case XSSFCell.CELL_TYPE_NUMERIC:
						System.out.println("Cell Value: "
								+ myCell.getNumericCellValue());
						break;
					case XSSFCell.CELL_TYPE_STRING:
						System.out.println("Cell Value: "
								+ myCell.getStringCellValue());
						break;
					default:
						System.out.println("Cell Value: "
								+ myCell.getRawValue());
						break;
					}

					System.out.println("---");

				}

			}

			myWorkBook.close();

		} catch (Exception e) {
			throw new Exception("Failed to process .xlsx file. "
					+ e.getMessage());
		}
	}

}
