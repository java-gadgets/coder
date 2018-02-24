package org.pplm.gadgets.coder.utils;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import freemarker.template.TemplateMethodModelEx;
import freemarker.template.TemplateModelException;

public class Camel2Underline implements TemplateMethodModelEx {

	@SuppressWarnings("rawtypes")
	@Override
	public Object exec(List args) throws TemplateModelException {
		if (args.size() == 0) {
			throw new TemplateModelException("invalidation parameter");
		}
		return camel2Underline(args.get(0).toString());
	}

	private String camel2Underline(String camel) {
		if (camel == null || "".equals(camel)) {
			return "";
		}
		camel = String.valueOf(camel.charAt(0)).toUpperCase().concat(camel.substring(1));
		StringBuffer stringBuffer = new StringBuffer();
		Pattern pattern = Pattern.compile("[A-Z]([a-z\\d_]+)?");
		Matcher matcher = pattern.matcher(camel);
		while (matcher.find()) {
			String word = matcher.group();
			stringBuffer.append(word.toLowerCase());
			stringBuffer.append(matcher.end() == camel.length() ? "" : "_");
		}
		return stringBuffer.toString();
	}

}
