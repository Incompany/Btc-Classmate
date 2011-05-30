//Declared Models
var Presentation = Model("presentation", function() {
  this.unique_key = "_id";
})
 

function init() {
	$(":text").labelify();
	$("textarea").labelify();
}

$(document).ready(function() {
	init();

	app = $.sammy('body', function(){ 
		this.use(Sammy.JSON);
		this.debug = true;
		
		this.get('#/',function() {
			var context = this;
			this.trigger('load_presentaciones',{id: 'root'});
		});
		
		this.bind('run', function() {
			var context = this;
			app = this;
			this.redirect('#/');
		});
	});
	
	app.run('#/');

});


//= require <app/controller/Presentation_Controller.js>
 

