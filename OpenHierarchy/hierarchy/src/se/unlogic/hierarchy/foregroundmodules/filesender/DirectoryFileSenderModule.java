package se.unlogic.hierarchy.foregroundmodules.filesender;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import se.unlogic.hierarchy.core.annotations.ModuleSetting;
import se.unlogic.hierarchy.core.annotations.TextFieldSettingDescriptor;
import se.unlogic.hierarchy.core.beans.User;
import se.unlogic.hierarchy.core.exceptions.ModuleConfigurationException;
import se.unlogic.hierarchy.core.exceptions.URINotFoundException;
import se.unlogic.hierarchy.core.interfaces.ForegroundModuleResponse;
import se.unlogic.hierarchy.foregroundmodules.AnnotatedForegroundModule;
import se.unlogic.standardutils.io.FileUtils;
import se.unlogic.webutils.http.HTTPUtils;
import se.unlogic.webutils.http.URIParser;
import se.unlogic.webutils.http.enums.ContentDisposition;


public class DirectoryFileSenderModule extends AnnotatedForegroundModule {

	@ModuleSetting(allowsNull=true)
	@TextFieldSettingDescriptor(name="Directory", description="Path to the directory to be served by this module")
	private String dirPath;
	
	@Override
	public ForegroundModuleResponse processRequest(HttpServletRequest req, HttpServletResponse res, User user, URIParser uriParser) throws Throwable {

		if(dirPath == null){

			throw new ModuleConfigurationException("Directory path not set");
		}

		if(uriParser.size() != 2){
			
			throw new URINotFoundException(uriParser);
		}
		
		File file = new File(dirPath + File.separator + uriParser.get(1));

		if(!FileUtils.isReadable(file) || file.isDirectory()){

			throw new URINotFoundException(uriParser);
		}

		log.info("User " + user + " downloading file " + file.getName());

		try {
			HTTPUtils.sendFile(file, req, res, ContentDisposition.INLINE);

		} catch (IOException e) {

			log.info("Error sending file " + file + " to user " + user);

		}

		return null;
	}
}
