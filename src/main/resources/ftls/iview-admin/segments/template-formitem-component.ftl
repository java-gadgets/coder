<#if attr.type! == "datetime">
${spaces!}                    <DatePicker v-model="optForm.${optName!}.${attr.code!}" format="yyyy-MM-dd HH:mm:ss" type="datetime" placement="bottom-end" placeholder="请选择${attr.name!}"></DatePicker>
<#elseif attr.type! == "date">
${spaces!}                    <DatePicker v-model="optForm.${optName!}.${attr.code!}" format="yyyy/MM/dd" type="date" placement="bottom-end" placeholder="请选择${attr.name!}"></DatePicker>
<#elseif attr.type! == "year">
${spaces!}                    <DatePicker v-model="optForm.${optName!}.${attr.code!}" format="yyyy" type="date" placement="bottom-end" placeholder="请选择${attr.name!}"></DatePicker>
<#elseif attr.type! == "month">
${spaces!}                    <DatePicker v-model="optForm.${optName!}.${attr.code!}" format="yyyy-MM" type="date" placement="bottom-end" placeholder="请选择${attr.name!}"></DatePicker>
<#elseif attr.type! == "select">
${spaces!}                    <Select v-model="optForm.${optName!}.${attr.code!}" clearable placeholder="请选择${attr.name!}">
${spaces!}                        <Option v-for="item in dict.${attr.code!}" :value="item.value" :key="item.value">{{ item.label }}</Option>
${spaces!}                    </Select>
<#elseif attr.type! == "radio">
${spaces!}                    <RadioGroup v-model="optForm.${optName!}.${attr.code!}">
${spaces!}                        <Radio v-for="item in dict.${attr.code!}" :label="item.value" :key="item.value">{{ item.label }}</Radio>
${spaces!}                    </RadioGroup>
<#elseif attr.type! == "pics">
${spaces!}                    <div class="pic-upload-list" v-for="item in upload.${attr.code}.uploadList">
${spaces!}                        <template v-if="item.status === 'finished'">
${spaces!}                            <img :src="item.response.content">
${spaces!}                            <div class="pic-upload-list-cover">
${spaces!}                                <Icon type="ios-eye-outline" @click.native="${attr.code}HandleView(item.response.content)"></Icon>
${spaces!}                                <Icon type="ios-trash-outline" @click.native="${attr.code}HandleRemove(item)"></Icon>
${spaces!}                            </div>
${spaces!}                        </template>
${spaces!}                        <template v-else>
${spaces!}                            <Progress v-if="item.showProgress" :percent="item.percentage" hide-info></Progress>
${spaces!}                        </template>
${spaces!}                    </div>
${spaces!}                    <Upload
${spaces!}                        ref="${attr.code}Upload"
${spaces!}<#include "../spec/" + project.code + "/upload-component-attrs.ftl" ignore_missing=true />
${spaces!}                        :show-upload-list="false"
${spaces!}                        :default-file-list="upload.${attr.code}.defaultUploadList"
${spaces!}                        :format="['jpg','jpeg','png']"
${spaces!}                        :max-size="2048"
${spaces!}                        :on-format-error="${attr.code}HandleFormatError"
${spaces!}                        :on-exceeded-size="${attr.code}HandleMaxSize"
${spaces!}                        :before-upload="${attr.code}HandleBeforeUpload"
${spaces!}                        multiple
${spaces!}                        type="drag"
${spaces!}                        :action="upload.url"
${spaces!}                        style="display: inline-block;width:58px;">
${spaces!}                        <div style="width: 58px;height:58px;line-height: 58px;">
${spaces!}                            <Icon type="camera" size="20"></Icon>
${spaces!}                        </div>
${spaces!}                   </Upload>
${spaces!}                   <Modal title="图片预览" width="50%" v-model="upload.${attr.code}.visible">
${spaces!}                        <img :src="upload.${attr.code}.imageUrl" v-if="upload.${attr.code}.visible" style="width: 100%;">
${spaces!}                   </Modal>
<#else>
${spaces!}                    <Input type="<#if attr.type! == "textarea">textarea<#elseif attr.type! == "password">password<#else>text</#if>" v-model="optForm.${optName!}.${attr.code!}"></Input>
</#if>
