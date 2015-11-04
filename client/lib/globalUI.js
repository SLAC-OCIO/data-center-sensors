globalUI = {};
globalUI.toast = {template: new ReactiveVar(""), data: new ReactiveVar()};
globalUI.toast.show = function(template, data, duration){
	check(template, String);
	globalUI.toast.template.set(template);
	globalUI.toast.data.set(data);
	globalUI.toast.element = globalUI.toast.element ||
	                         document.querySelector("paper-toast");
	if (globalUI.toast.element && globalUI.toast.element.show){
		globalUI.toast.element.duration = duration || 3000;
		globalUI.toast.element.show();
	}
},

Template.registerHelper("toastTemplate", function(argument){
	return globalUI.toast.template.get();
});

Template.registerHelper("toastData", function(argument){
	return globalUI.toast.data.get();
});
