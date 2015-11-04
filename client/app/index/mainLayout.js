Template.mainLayout.events({
	"click paper-drawer-panel a": function(event, template){
		template.find("paper-drawer-panel").closeDrawer();
	},
	"iron-overlay-closed": function(event, template){
		FlowRouter.setQueryParams({dialog: null});
	},
	"iron-overlay-opened": function(event, template){
		template.find("paper-dialog").notifyResize();
	},
});
Template.home.events({
	"click #showToast": function(event, template){
		globalUI.toast.show("sampleToast");
	},
});
//Polymer Functions
//Polymer()