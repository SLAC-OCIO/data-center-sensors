
/*
Template.home.helpers({
	'search-bar', {
	showingSearch: false,
	openSearch: function() {
		if (this.showingSearch) {
			return;
		}
		this.showingSearch = !this.showingSearch;
		this.classList.toggle('search-on');
		this.$.button.icon='arrow-back';
	},
	closeSearch: function() {
		if (!this.showingSearch) {
			return;
		}
		this.showingSearch = !this.showingSearch;
		this.classList.toggle('search-on');
		this.$.button.icon='search';
	},
	toggleSearch: function(e, detail, sender) {
		if (e) { // comes first
			e.stopPropagation();
		}
		if (e.target === this.$.input) {
			return;
		}
		this.showingSearch = !this.showingSearch;
		this.classList.toggle('search-on');
		this.async(function() {
			this.$.input.focus();
			if (this.showingSearch) {
				this.$.button.icon='arrow-back';
				if (location.hash == '') {
					this.$.previous='/';
				}
				else {
					this.$.previous=location.hash.substring(1);
				}
				document.querySelector('app-router').go('/search');
			} else {
				this.$.button.icon='search';
				document.querySelector('app-router').go(this.$.previous);

			}
		});
	},
	onKeyPress: function(e, detail, sender) {
		if (e.keyCode == 13) { // Enter
			if (sender.value) {
				if (localStorage.getItem("searchlist")) {
					this.sl=JSON.parse(localStorage.getItem("searchlist"));
				}
				else {
					this.sl={};
				}
				this.sl[sender.value]=1+sl[sender.value];
				localStorage.setItem("searchlist",JSON.stringify(this.sl));
				if (this.showingSearch) {
					this.toggleSearch(e);
				}
				this.async(function(){window.location.hash = "/results?search="+sender.value;});
			}
		}
	},
});
*/