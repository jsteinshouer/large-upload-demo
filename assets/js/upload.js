import Alpine from 'https://esm.sh/alpinejs@3.13.0'

function uuid() {
	return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
		var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
		return v.toString(16);
	});
}

Alpine.data('myForm', () => ({
	file: null,
	dialogOpen: false,
	uploadComplete: false,
	uploadProgress: 0,
	uploadTarget: 0,
	loadFile() {
		let elem = document.getElementById("fileInput");
		this.file = elem.files[0];
		this.uploadComplete = false;
		this.uploadTarget = 0;
		this.uploadProgress = 0;
		// console.log(this.file)
	},
	cancel() {
		this.uploadComplete = false;
		this.uploadTarget = 0;
		this.uploadProgress = 0;
		this.dialogOpen = false;
		this.file = null;
		let elem = document.getElementById("fileInput");
		elem.value = ''
	},
	async submit() {
		let formData = new FormData();
		formData.append("file", this.file);
		formData.append("fileName", this.file.name);

		const response = await fetch("/main/upload", {
			method: "POST",
			body: formData
		});

		if (response.status == 200) {
			this.uploadComplete = true;
		}
		else {
			alert("An error occured while uploading your file.")
		}
	},
	async submitChunks() {
		const fileID = uuid();

		const file = this.file;
		const chunkSize = 1000000;
		this.uploadTarget = parseInt(file.size / chunkSize);
		for (let start = 0; start < file.size; start += chunkSize) {
			const chunk = file.slice(start, start + chunkSize)
			let formData = new FormData();
			formData.append("chunk", chunk);
			formData.append("fileName", this.file.name);
			formData.append("fileID", fileID);
			const response = await fetch("/main/uploadChunk", {
				method: "POST",
				body: formData
			});
			this.uploadProgress++;
		}

		this.uploadComplete = true;
	}
}))


Alpine.start()