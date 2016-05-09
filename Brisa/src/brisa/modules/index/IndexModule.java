package brisa.modules.index;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import se.unlogic.hierarchy.core.annotations.WebPublic;
import se.unlogic.hierarchy.core.beans.SimpleForegroundModuleResponse;
import se.unlogic.hierarchy.core.beans.User;
import se.unlogic.hierarchy.core.interfaces.ForegroundModuleResponse;
import se.unlogic.hierarchy.foregroundmodules.AnnotatedForegroundModule;
import se.unlogic.standardutils.json.JsonArray;
import se.unlogic.standardutils.json.JsonObject;
import se.unlogic.standardutils.xml.XMLUtils;
import se.unlogic.webutils.http.HTTPUtils;
import se.unlogic.webutils.http.RequestUtils;
import se.unlogic.webutils.http.URIParser;

public class IndexModule extends AnnotatedForegroundModule {

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
	public ForegroundModuleResponse getSurveyData(HttpServletRequest req,
			HttpServletResponse res, User user, URIParser uriParser)
			throws SQLException, IOException {

		JsonObject result = new JsonObject();
		StringBuilder stringBuilder = new StringBuilder();

		try {

			// Get parameters
			// String queryId = req.getParameter("queryId");

			// Call db
			// ArrayList<CalculationBasisParameter> parameters =
			// calculationBasisParameterDAO.listByQueryId(queryId);

			JsonArray parametersJsonArray = new JsonArray();

			result.putField("parameters", parametersJsonArray);

			result.putField("success", "1");
			result.toJson(stringBuilder);
			HTTPUtils.sendReponse(stringBuilder.toString(), "application/json",
					res);

		} catch (Exception ex) {
			// TODO log error
			result.putField("message", "Ett fel inträffade på servern.");
			result.putField("success", "0");
			result.toJson(stringBuilder);
			HTTPUtils.sendReponse(stringBuilder.toString(), "application/json",
					res);
		}

		return null;
	}
}
