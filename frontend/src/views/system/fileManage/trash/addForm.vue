<template>
	<a-modal
	  title="新增回收站"
	  :width="900"
	  :visible="visible"
	  :confirmLoading="confirmLoading"
	  @ok="handleSubmit"
	  @cancel="handleCancel">
		<a-spin :spinning="confirmLoading">
			<a-form :form="form">
					<a-form-item label="名称" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback="">
						<a-input placeholder="请输入名称" v-decorator="['name']" />
						
					</a-form-item>
					<a-form-item label="类型" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback="">
						<a-input-number placeholder="请输入类型" style="width: 100%" v-decorator="['documentType']" />
						
					</a-form-item>
					<a-form-item label="文件后缀" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback="">
						<a-input placeholder="请输入文件后缀" v-decorator="['fileSuffix']" />
						
					</a-form-item>
					<a-form-item label="文件大小kb" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback="">
						<a-input-number placeholder="请输入文件大小kb" style="width: 100%" v-decorator="['fileSizeKb']" />
						
					</a-form-item>
					<a-form-item label="存储后的文件名" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback="">
						<a-input placeholder="请输入存储后的文件名" v-decorator="['fileObjectName']" />
						
					</a-form-item>
					<a-form-item label="标签" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback="">
						<a-input-number placeholder="请输入标签" style="width: 100%" v-decorator="['label']" />
						
					</a-form-item>
					<a-form-item label="备注" :labelCol="labelCol" :wrapperCol="wrapperCol" has-feedback="">
						<a-input placeholder="请输入备注" v-decorator="['remark']" />
						
					</a-form-item>
				</a-form>
		</a-spin>
	</a-modal>
</template>

<script>
	import {
	TrashAdd
	} from '@/api/modular/system/fileManage/trashManage'

	export default {
	data () {
	return {
	labelCol: {
	xs: { span: 24 },
	sm: { span: 6 }
	},
	wrapperCol: {
	xs: { span: 24 },
	sm: { span: 16 }
	},
	visible: false,
	confirmLoading: false,
	form: this.$form.createForm(this)
	}
	},
	methods: {
	// 初始化方法
	add (record) {
	this.visible = true
	},
	/**
	* 提交表单
	*/
	handleSubmit () {
	const { form: { validateFields } } = this
	this.confirmLoading = true
	validateFields((errors, values) => {
	if (!errors) {
	for (const key in values) {
	if (typeof (values[key]) === 'object') {
	values[key] = JSON.stringify(values[key])
	}
	}
	TrashAdd(values).then((res) => {
	if (res.success) {
	this.$message.success('新增成功')
	this.confirmLoading = false
	this.$emit('ok', values)
	this.handleCancel()
	} else {
	this.$message.error('新增失败'+ res.message)// + res.message
	}
	}).finally((res) => {
	this.confirmLoading = false
	})
	} else {
	this.confirmLoading = false
	}
	})
	},
	handleCancel () {
	this.form.resetFields()
	this.visible = false
	}
	}
	}
</script>
