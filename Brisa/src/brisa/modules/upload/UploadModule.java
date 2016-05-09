package brisa.modules.upload;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import se.unlogic.hierarchy.core.annotations.WebPublic;
import se.unlogic.hierarchy.core.beans.SimpleForegroundModuleResponse;
import se.unlogic.hierarchy.core.beans.User;
import se.unlogic.hierarchy.core.handlers.UserHandler;
import se.unlogic.hierarchy.core.interfaces.ForegroundModuleResponse;
import se.unlogic.hierarchy.foregroundmodules.AnnotatedForegroundModule;
import se.unlogic.standardutils.json.JsonArray;
import se.unlogic.standardutils.json.JsonObject;
import se.unlogic.standardutils.xml.XMLUtils;
import se.unlogic.webutils.http.HTTPUtils;
import se.unlogic.webutils.http.RequestUtils;
import se.unlogic.webutils.http.URIParser;
import brisa.model.Status;
import brisa.repositories.StatusRepository;

@Configurable
public class UploadModule extends AnnotatedForegroundModule {

	@Autowired
	private StatusRepository _statusRepository;
	
	private long _statusId = 0;
	
	@Override
	public SimpleForegroundModuleResponse defaultMethod(HttpServletRequest req,
			HttpServletResponse res, User user, URIParser uriParser)
			throws Exception {
		Document doc = XMLUtils.createDomDocument();

		Element document = doc.createElement("document");
		doc.appendChild(document);
		document.appendChild(RequestUtils.getRequestInfoAsXML(doc, req,
				uriParser));
		document.appendChild(moduleDescriptor.toXML(doc));
		document.appendChild(user.toXML(doc));
		
		return new SimpleForegroundModuleResponse(doc,
				this.moduleDescriptor.getName(), this.getDefaultBreadcrumb());

	}

	@WebPublic
	public ForegroundModuleResponse excel(HttpServletRequest req,
			HttpServletResponse res, User user, URIParser uriParser)
			throws SQLException, IOException {

		JsonObject result = new JsonObject();
		StringBuilder stringBuilder = new StringBuilder();

		try {

			// Get the file
			ExcelUploadFactory euf = new ExcelUploadFactory(req, res);
			File file = euf.getFile();
			String fullName = euf.getFullName();

			// Process it
			new ExcelProcessor().processFile(file, fullName);

			writeStatus("1");

			// statusDao.te

			// Okey, we made it!
			JsonArray parametersJsonArray = new JsonArray();
			result.putField("parameters", parametersJsonArray);
			result.putField("success", "1");
			result.toJson(stringBuilder);
			HTTPUtils.sendReponse(stringBuilder.toString(), "application/json",
					res);

		} catch (Exception ex) {
			writeStatus("0");
			result.putField("message", "Ett fel inträffade på servern.");
			result.putField("success", "0");
			result.toJson(stringBuilder);
			HTTPUtils.sendReponse(stringBuilder.toString(), "application/json",
					res);
		}

		return null;
	}

	@WebPublic
	public ForegroundModuleResponse getUploadStatus(HttpServletRequest req,
			HttpServletResponse res, User user, URIParser uriParser)
			throws SQLException, IOException {

		JsonObject result = new JsonObject();
		StringBuilder stringBuilder = new StringBuilder();

		try {
			result.putField("fileupload", getUploadStatus());
			result.toJson(stringBuilder);
			HTTPUtils.sendReponse(stringBuilder.toString(), "application/json",
					res);

		} catch (Exception ex) {
			result.putField("message", "Ett fel inträffade på servern.");
			result.putField("success", "0");
			result.toJson(stringBuilder);
			HTTPUtils.sendReponse(stringBuilder.toString(), "application/json",
					res);
		}

		return null;
	}

	private void writeStatus(String message) {
		Status s = new Status("fileupload", message);
		try {
			_statusRepository.save(s);
			_statusId = s.getId();	//Save status id
			
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
	}

	private String getUploadStatus() {
		try {
			Status status = _statusRepository.findOne(_statusId);
			if (status!=null)
				return status.getMessage();
			else
				return "";
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
		return "";
	}
}