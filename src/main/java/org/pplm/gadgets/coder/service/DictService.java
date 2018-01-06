package org.pplm.gadgets.coder.service;

import org.pplm.gadgets.coder.bean.DictExample;
import org.pplm.gadgets.coder.bean.DictItem;
import org.pplm.gadgets.coder.bean.DictItemExample;
import org.pplm.gadgets.coder.mapper.DictItemMapper;
import org.pplm.gadgets.coder.mapper.DictMapper;

import java.util.List;

import org.pplm.gadgets.coder.bean.Dict;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class DictService extends BaseService<Dict, DictExample> {

	@Autowired
	private DictItemMapper dictItemMapper;
	
	@Autowired
	public DictService(DictMapper mapper) {
		super(mapper);
	}
	
	@Override
	public Page<Dict> selectByExample(DictExample example, Pageable pageable) {
		Page<Dict> dicts = super.selectByExample(example, pageable);
		dicts.forEach(dict -> {
			dict.setDictItems(selectDictItems(dict.getId()));
		});
		return dicts;
	}
	
	@Override
	public List<Dict> selectByExample(DictExample example) {
		List<Dict> dicts = super.selectByExample(example);
		dicts.forEach(dict -> {
			dict.setDictItems(selectDictItems(dict.getId()));
		});
		return dicts;
	}
	
	@Override
	public Dict selectByPrimaryKey(Long id) {
		Dict dict = super.selectByPrimaryKey(id);
		if (dict != null) {
			dict.setDictItems(selectDictItems(dict.getId()));
		}
		return dict;
	}
	
	@Override
	public int insertSelective(Dict dict) {
		int flag = super.insertSelective(dict);
		Long did = dict.getId();
		if (did == null) {
			return -1;
		}
		processDictItems(did, dict.getDictItems());
		return flag;
	}
	
	public int updateByPrimaryKeySelective(Dict dict) {
		if (dict.getDeleteFlag() == null || dict.getDeleteFlag() != 1) {
			Long did = dict.getId();
			deleteDictItems(did);
			processDictItems(did, dict.getDictItems());
		}
		return super.updateByPrimaryKeySelective(dict);
	}
	
	private void processDictItems(Long did, List<DictItem> dictItems) {
		if (dictItems != null) {
			insertDictItems(did, dictItems);
		}
	}
	
	private List<DictItem> selectDictItems(Long did) {
		DictItemExample example = new DictItemExample();
		example.createCriteria().andDidEqualTo(did);
		return dictItemMapper.selectByExample(example);
	}
	
	private void deleteDictItems (Long did) {
		DictItemExample example = new DictItemExample();
		example.createCriteria().andDidEqualTo(did);
		dictItemMapper.deleteByExample(example);
	}
	
	private void insertDictItems (final Long did, List<DictItem> dictItems) {
		dictItems.forEach(dictItem -> { 
			dictItem.setDid(did);
			dictItemMapper.insertSelective(dictItem);
		});
	}
}
