package brisa.modules.connect;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import se.unlogic.hierarchy.core.beans.SimpleForegroundModuleResponse;
import se.unlogic.hierarchy.core.beans.User;
import se.unlogic.hierarchy.foregroundmodules.AnnotatedForegroundModule;
import se.unlogic.standardutils.xml.XMLUtils;
import se.unlogic.webutils.http.RequestUtils;
import se.unlogic.webutils.http.URIParser;

public class ConnectModule extends AnnotatedForegroundModule {

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

}
