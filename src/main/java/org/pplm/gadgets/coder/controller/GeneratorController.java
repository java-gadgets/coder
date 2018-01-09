package org.pplm.gadgets.coder.controller;

import java.io.IOException;
import java.io.StringWriter;
import java.util.Map;

import org.pplm.gadgets.coder.bean.Dict;
import org.pplm.gadgets.coder.bean.Func;
import org.pplm.gadgets.coder.bean.Opt;
import org.pplm.gadgets.coder.bean.Record;
import org.pplm.gadgets.coder.service.DictService;
import org.pplm.gadgets.coder.service.FuncService;
import org.pplm.gadgets.coder.service.OptService;
import org.pplm.gadgets.coder.utils.ResHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.http.MediaType;
import org.springframework.ui.freemarker.SpringTemplateLoader;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import freemarker.cache.TemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

@RestController
@RequestMapping(path = "/v1/gen", produces = MediaType.APPLICATION_JSON_VALUE)
public class GeneratorController {

	@Autowired
	private FuncService funcService;
	
	@Autowired
	private OptService optService;
	
	@Autowired
	private DictService dictService;

	@PostMapping(path = "/func/{framework}/{type}/{fid}")
	public Map<String, Object> onPostGenFunc(@PathVariable(name = "framework", required = true) String framework,
			@PathVariable(name = "type", required = true) String type,
			@PathVariable(name = "fid", required = true) Long fid) throws IOException, TemplateException {
		Func func = funcService.selectWithProjectAndOptsByPrimaryKey(fid);
		return ResHelper.success(genCode(func, framework + "/" + type + ".ftl"));
	}

	@PostMapping(path = "/opt/{framework}/{type}/{oid}")
	public Map<String, Object> onPostGenOpt(@PathVariable(name = "framework", required = true) String framework,
			@PathVariable(name = "type", required = true) String type,
			@PathVariable(name = "oid", required = true) Long oid) throws IOException, TemplateException {
			Opt opt = optService.selectWithAttrAndProjectByPrimaryKey(oid);
		return ResHelper.success(genCode(opt, framework + "/" + type + ".ftl"));
	}
	
/*	@PostMapping(path = "/vue/{id}")
	public Map<String, Object> onPostList(@PathVariable(name = "id") String id,
			@RequestParam(name = "type", required = false, defaultValue = "list") String type)
			throws IOException, TemplateException {
		Func func = null; // funcRepository.findOne(id);
		if (func == null) {
			return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
		}
		return ResHelper.success(genCode(func, type + ".ftl", "/iview-admin"));
	}*/

	@PostMapping(path = "/vue/dict/{id}")
	public Map<String, Object> onPostDictGen(@PathVariable(name = "id") Long id)
			throws IOException, TemplateException {
		Dict dict = dictService.selectByPrimaryKey(id);
		return ResHelper.success(genCode(dict, "dict.ftl", ""));
	}
/*
	@PostMapping(path = "/vue/permission/{pid}")
	public Map<String, Object> onPermissionGen(@PathVariable(name = "pid") String pid)
			throws IOException, TemplateException {
		Project project = null; // projectRepository.findOne(pid);
		return ResHelper.success(genCode(project, "/wsh/iview-admin/permission.ftl", ""));
	}

	@PostMapping(path = "/vue/opt/{type}/{id}")
	public Map<String, Object> onPostSaveGen(@PathVariable(name = "type") String type,
			@PathVariable(name = "id") String id) throws IOException, TemplateException {
		Opt opt = null; // optRepository.findOne(id);
		String templateFileName = null;
		if ("update".equals(type) || "add".equals(type)) {
			templateFileName = "save-wsh.ftl";
		} else if ("save".equals(type)) {
			templateFileName = "/wsh/iview-admin/save-wsh.ftl";
		} else if ("detail".equals(type)) {
			templateFileName = "/wsh/iview-admin/detail-wsh.ftl";
		} else {
			return ResHelper.error("invalid type");
		}
		return ResHelper.success(genCode(opt, templateFileName, ""));
	}
*/
	private String genCode(Record record, String templateFileName, String path) throws IOException, TemplateException {
		Configuration config = new Configuration(Configuration.VERSION_2_3_26);
		config.setDefaultEncoding("utf-8");
		TemplateLoader templateLoader = new SpringTemplateLoader(new DefaultResourceLoader(), "ftls" + path);
		config.setTemplateLoader(templateLoader);
		Template template = config.getTemplate(templateFileName, "utf-8");
		StringWriter stringWriter = new StringWriter();
		template.process(record, stringWriter);
		System.out.println(stringWriter.toString());
		return stringWriter.toString();
	}
	
	private String genCode(Record record, String templateFile) throws IOException, TemplateException {
		Configuration config = new Configuration(Configuration.VERSION_2_3_26);
		config.setDefaultEncoding("utf-8");
		TemplateLoader templateLoader = new SpringTemplateLoader(new DefaultResourceLoader(), "ftls" + "");
		config.setTemplateLoader(templateLoader);
		Template template = config.getTemplate(templateFile, "utf-8");
		StringWriter stringWriter = new StringWriter();
		template.process(record, stringWriter);
		System.out.println(stringWriter.toString());
		return stringWriter.toString();
	}

}
