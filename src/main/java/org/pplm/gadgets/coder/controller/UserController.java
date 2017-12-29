package org.pplm.gadgets.coder.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.pplm.gadgets.coder.entity.User;
import org.pplm.gadgets.coder.repository.UserRepository;
import org.pplm.gadgets.coder.utils.ResHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/v1/user", produces = MediaType.APPLICATION_JSON_VALUE)
public class UserController {
	
//	@Autowired
	private UserRepository userRepository;
	
	@GetMapping(path = "/list")
	public Map<String, Object> onGetQuery(HttpServletRequest request, Pageable pageable){
		return ResHelper.success(userRepository.findAllByDeleteFlag(0, pageable));
	}

	@PostMapping(path="/save", consumes = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> onPostCreate(@RequestBody User user) {
		if (user != null) {
			//return ResHelper.success(userRepository.save(user));
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_BODY);
	}
	
	@GetMapping(path = "/detail")
	public Map<String, Object> onGetDetail(@RequestParam("id") String id) {
		User user = userRepository.findOneByIdAndDeleteFlag(id, 0);
		if (user != null) {
			return ResHelper.success(user);
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
	@PostMapping(path="/delete/{id}")
	public Map<String, Object> onPostDelete(@PathVariable("id") String id) {
		if(id != null) {
			User user = userRepository.findOneByIdAndDeleteFlag(id, 0);
			if(user != null) {
				user.setDeleteFlag(1);
				//userRepository.save(user);
				return ResHelper.success();
			}
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
	@PostMapping(path="/update/status/{id}")
	public Map<String, Object> onPostUpdateStatus(@PathVariable(name = "id") String id, @RequestParam(name = "status") String status) {
		if(id != null && status != null) {
			userRepository.updateStatus(id, status);
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
	@PostMapping(path="/update/restPassword/{id}")
	public Map<String, Object> onPostUpdateRestPassword(@PathVariable(name = "id") String id) {
		User user = userRepository.findOneByIdAndDeleteFlag(id, 0);
		if(user != null) {
			return ResHelper.success();
		}
		return ResHelper.error(ResHelper.MESSAGE_ERROR_ID);
	}
	
}
