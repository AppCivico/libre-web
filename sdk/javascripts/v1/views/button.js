// requires
require("fetch-ie8");
const Promise = require("promise-polyfill");
const ViewBase = require("lib/view.js");


/**
 *	Button component class
 *	author: @dvinciguerra
 */
module.exports = class ButtonView extends ViewBase {

	constructor(args = {}) {
		super(args);
		this._getDataAttributes();
	}

	getData(key = null) {
		if (key != null) {
			return this._data[key];
		}
		return this._data;
	}

	isRendered() {
		return this._rendered;
	}



	isJournalist() {
		let s = this.session();
		return (s.getAttr("roles") || [])[0] === "journalist" ? true : false;
	}

	isDonor() {
		let s = this.session();
		return (s.getAttr("roles") || [])[0] === "donor" ? true : false;
	}

	isAuth() {
		let s = this.session();
		return s.isAuth() ? true : false;
	}

	bind() {
		let self = this;

		let button = this.el().querySelectorAll(".lbr-sdk-button");
		if(button != null){
			button.forEach((x) => {
				x.addEventListener("submit", (event) => {
					return self.onSupportSubmit(self, event);
				}, false);
			});
		}
	}

	// DOC: https://github.com/eokoe/libre-api/blob/master/t/donor/004-support.t#L21
	onSupportSubmit(self, event) {
		event.preventDefault();

		let data = {
			"page_title": document.title || "",
			"page_referer": document.location.href,
			"uid": self._data.uid, //
			"api_key": self.session().getAttr("api_key"),
			"referer": document.location.href,
		};

		// user is not authenticated
		if (!self.isAuth()) {
			let session = self.session();
			session.setItem("donation", data);

			//let rootLocation = '//devlibre.eokoe.com';
			let rootLocation = "//midialibre.com.br";
			let location = `${rootLocation}/account/external/login?act=support&referer=${encodeURIComponent(document.location.href)}`;
			window.open(location, '_blank', 'width=400,height=460,scrollbars=no,centerscreen=yes,chrome=yes');
			//document.location = `//midialibre.com.br/account/login?act=support&referer=${encodeURIComponent(document.location.href)}`;
			//document.location = `//devlibre.eokoe.com/account/login?act=support&referer=${encodeURIComponent(document.location.href)}`;
			return false;
		}

		// user is authenticated but role is not allowed
		if (self.isAuth()) {
			if (self.isJournalist()) {
				alert("[Libre] Você não pode doar estando logado como jornalista");
				return false;
			}
		}

		// confirmation of support
		if (confirm("Você confirma a contribuição de 1 Libre por este conteúdo?")) {
			let params = new FormData();
			for (var i in data) {
				console.log(i, data[i]);
				params.append(i, data[i]);
			}

			// DEBUG: console.log(`//hapilibre.eokoe.com/api/journalist/${journalist.user_id}/support?api_key=${donor.api_key}`);
			let apikey = self.session().getAttr("api_key");
			console.log(self._data);
			var f = fetch(`//hapilibre.eokoe.com/api/journalist/${self._data.uid}/support?api_key=${apikey}`, {
				method: 'POST',
				body: params
			}).then((res) => {
				// success
				if (res.status >= 300) {
					return res;
				}
				console.log(res.json());
				alert("Muito obrigado! Sua colaboração foi computada com sucesso.");

				// change button on support has success
				var list = document.querySelectorAll(".lbr-sdk-btn-support");
				list.forEach( (item) => {
					item.style.display = "none";
					var thanks = item.parentNode.querySelector(".lbr-sdk-btn-thanks");
					if(thanks != null){
						thanks.style.display = "";
					}
				});


			}).then((res) => {
				// error
				if (res.status >= 400 && res.status < 500) {
					console.error(`Error: ${res}`);
				}
				console.log(res.json());

			}).catch(function(error) {
				console.error(`Button#supportSubmit event: ${error}`);

			});
		}
	}

	render() {
		if (!this.isRendered()) {
			let tmpl = this.template({
				config: this.config()
			});
			this.el().innerHTML = tmpl;
			this.bind();
			this._rendered = true;
		}
		return this.el();
	}

	template(stash = {}) {
		// TODO: maybe use a templete engine here in fucture
		// TODO: maybe in fucture use an iframe
		return `
			<form class="lbr-sdk-button" href="#" style="">
				<input class="lbr-sdk-btn-thanks"
					type="image"
					src="${stash.config.base + stash.config.assets.button_thanks}"
					height="30px"
					title="Obrigado por colaborar!"
					style="display: none"
					onclick="return false;" />
				<input class="lbr-sdk-btn-support"
					type="image"
					src="${stash.config.base + stash.config.assets.button}"
					height="30px"
					title="Gostou? Valorize, dê um Libre" />
			</form>
		`;
	}

	/**
	 * Getting data-* attrs from element
	 */
	_getDataAttributes() {
		this._data = {};

		let el = (this._el !== null || this._el !== undefined) ? this._el : null;
		try {
			for (let i = 0; i < el.attributes.length; i++) {
				if (el.attributes[i].name && el.attributes[i].name.match(/^data-/)) {
					let k = el.attributes[i].name.replace(/^data-/, '');
					this._data[k] = el.attributes[i].value;
				}
			}
		} catch (e) {
			throw new Error(`Button#_getDataAttributes error: ${e.message}`);
		}

		return this._data;
	}
}

