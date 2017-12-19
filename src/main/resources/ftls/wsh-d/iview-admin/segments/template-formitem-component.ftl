<#if attr.type! == "datetime" >
${spaces!}                    <DatePicker v-model="optForm.${optName!}.${attr.name!}" format="yyyy-MM-dd HH:mm:ss" type="datetime" placement="bottom-end" placeholder="请选择${attr.label!}"></DatePicker>
<#elseif attr.type! == "date" >
${spaces!}                    <DatePicker v-model="optForm.${optName!}.${attr.name!}" format="yyyy/MM/dd" type="date" placement="bottom-end" placeholder="请选择${attr.label!}"></DatePicker>
<#elseif attr.type! == "year" >
${spaces!}                    <DatePicker v-model="optForm.${optName!}.${attr.name!}" format="yyyy" type="date" placement="bottom-end" placeholder="请选择${attr.label!}"></DatePicker>
<#elseif attr.type! == "month" >
${spaces!}                    <DatePicker v-model="optForm.${optName!}.${attr.name!}" format="yyyy-MM" type="date" placement="bottom-end" placeholder="请选择${attr.label!}"></DatePicker>
<#elseif attr.type! == "select" >
${spaces!}                    <Select v-model="optForm.${optName!}.${attr.name!}" clearable placeholder="请选择${attr.label!}">
${spaces!}                        <Option v-for="item in dict.${attr.name!}" :value="item.value" :key="item.value">{{ item.label }}</Option>
${spaces!}                    </Select>
<#elseif attr.type! == "radio" >
${spaces!}                    <RadioGroup v-model="optForm.${optName!}.${attr.name!}">
${spaces!}                        <Radio v-for="item in dict.${attr.name!}" :label="item.value" :key="item.value">{{ item.label }}</Radio>
${spaces!}                    </RadioGroup>
<#elseif attr.type! == "pic" >
${spaces!}                    <div class="pic-upload-list" v-for="item in upload.${attr.name!}.uploadList">
${spaces!}                        <template v-if="item.status === 'finished'">
${spaces!}                            <img :src="item.response.content">
${spaces!}                            <div class="pic-upload-list-cover">
${spaces!}                                <Icon type="ios-eye-outline" @click.native="${attr.name!}HandleView(item.response.content)"></Icon>
${spaces!}                                <Icon type="ios-trash-outline" @click.native="${attr.name!}HandleRemove(item)"></Icon>
${spaces!}                            </div>
${spaces!}                        </template>
${spaces!}                        <template v-else>
${spaces!}                            <Progress v-if="item.showProgress" :percent="item.percentage" hide-info></Progress>
${spaces!}                        </template>
${spaces!}                    </div>
${spaces!}                    <Upload
${spaces!}                        ref="${attr.name!}Upload"
${spaces!}                        :show-upload-list="false"
${spaces!}                        :default-file-list="upload.${attr.name!}.defaultList"
${spaces!}                        :format="['jpg','jpeg','png']"
${spaces!}                        :max-size="2048"
${spaces!}                        :on-success="${attr.name!}HandleSuccess"
${spaces!}                        :on-format-error="${attr.name!}HandleFormatError"
${spaces!}                        :on-exceeded-size="${attr.name!}HandleMaxSize"
${spaces!}                        :before-upload="${attr.name!}HandleBeforeUpload"
${spaces!}                        type="drag"
${spaces!}                        :action="upload.url"
${spaces!}                        style="display: inline-block;width:58px;">
${spaces!}                        <div style="width: 58px;height:58px;line-height: 58px;">
${spaces!}                            <Icon type="camera" size="20"></Icon>
${spaces!}                        </div>
${spaces!}                   </Upload>
${spaces!}                   <Modal title="图片预览" v-model="upload.${attr.name!}.visible">
${spaces!}                        <img :src="upload.${attr.name!}.imageUrl" v-if="upload.${attr.name!}.visible" style="width: 100%">
${spaces!}                   </Modal>
<#else>
${spaces!}                    <Input type="<#if attr.type! == "textarea">textarea<#elseif attr.type! == "password">password<#else>text</#if>" v-model="optForm.${optName!}.${attr.name!}"></Input>
</#if>
