
<html>
<head>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css">
	<script type="module" src="/assets/js/upload.js"></script>
	<style>
		dialog article {
			min-width: 60%;
		}
	</style>
</head>
<body style="margin-top: 40px">
	<div x-data="myForm">
		<h1>Lorem ipsum</h1>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Montes nascetur ridiculus mus mauris vitae ultricies. Amet venenatis urna cursus eget nunc scelerisque viverra mauris in. Proin fermentum leo vel orci porta. Sit amet venenatis urna cursus eget nunc.</p>
		<hgroup>
		<h2>Heading 2</h2>
		<h3>Subtitle for heading 2</h3>
		</hgroup>
		<article>
			<figure><table><thead><tr><th scope="col">#</th><th scope="col">Heading</th><th scope="col">Heading</th><th scope="col">Heading</th><th scope="col">Heading</th><th scope="col">Heading</th></tr></thead><tbody><tr><th scope="row">1</th><td>Cell</td><td>Cell</td><td>Cell</td><td>Cell</td><td>Cell</td></tr><tr><th scope="row">2</th><td>Cell</td><td>Cell</td><td>Cell</td><td>Cell</td><td>Cell</td></tr><tr><th scope="row">3</th><td>Cell</td><td>Cell</td><td>Cell</td><td>Cell</td><td>Cell</td></tr></tbody><tfoot><tr><th scope="row">#</th><td>Total</td><td>Total</td><td>Total</td><td>Total</td><td>Total</td></tr></tfoot></table></figure>
		</article>
		<div class="grid">
			<div><button @click="dialogOpen = true">Send File</button></div>
			<div></div>
			<div></div>
		</div>
		<dialog :open="dialogOpen">
			<article >
				<header>
					<h3>Upload File</h3>
				</header>
				<p>
				<form method="POST" action="/main/upload">
					<input type="file" id="fileInput" @change="loadFile">
				</form>
				<template x-if="file">
					<table>
						<tbody>
							<tr>
								<th>Name</th>
								<td x-text="file.name"></td>
							</tr>
							<tr>
								<th>Size</th>
								<td x-text="parseInt(file.size / 1000000) + 'MB'"></td>
							</tr>
							<tr>
								<th>Type</th>
								<td x-text="file.type"></td>
							</tr>
						</tbody>
					</table>
				</template>
				<progress x-show="uploadProgress > 0" :value="uploadProgress" :max="uploadTarget"></progress>
				<p x-show="uploadComplete">Upload complete!</p>
				</p>
				<footer>
					<a href="#cancel" role="button" class="secondary" @click.prevent="cancel" x-show="!uploadComplete">Cancel</a>
					<a href="#confirm" role="button" :disabled="!file || uploadProgress > 0" @click.prevent="submitChunks" x-show="!uploadComplete">Upload</a>
					<a href="#close" role="button" x-show="uploadComplete" @click.prevent="cancel">Close</a>
				</footer>
			</article>
		</dialog>
	</div>
</body>
</html>