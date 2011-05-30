$.sammy('body', function(){ 
	
	this.bind('load_presentaciones', function(e,data) {
		var context =this;
			$.ajax({
				url: "/slides",
				type:"get",
				data: "parentId=" + data['id'],
				context: document.body,
				success: function(data){
					handle_load_presentaciones_success(data)
				},
				error: function(re,text,error) {
					handle_load_presentaciones_error(re)
				}
			});
	});

	function handle_load_presentaciones_success(data){
		Presentation.each(function() {
		  Presentation.remove(this);
		});
		var temp = JSON.parse(data);
		var count = temp.length -1;
		while (count>-1){
			var t = temp[count];
			savePresentation(t);
			count -=1;
		}
		Presentation.trigger("data_loaded")
	}

	function handle_load_presentaciones_error(){}

	this.bind('save_presentacion', function(e,data) {
		var context = this;
		var j = data['slide'];
		$.ajax({
			url: "/slide",
			data: "slide=" + app.json(j),
			type:"post",
			context: document.body,
			success: function(res){
				original = data
				response = res
				handle_save_presentacion_success(original,response);
			},
			error: function(re,text,error) {
				alert(re);
			}
		});
	});

	function handle_save_presentacion_success(original,response){
		slide = app.json(response);
		savePresentation(slide);
		Presentation.trigger("data_loaded")
	}

	this.bind('delete_presentacion', function(e,data) {
		var context = this;
		$.ajax({
			url: "/slide/" + data['id'],
			type:"post",
			context: document.body,
			success: function(res){
				handle_delete_presentacion_success(res,data);
			},
			error: function(re,text,error) {
				alert(re);
			}
		});
	});

	function handle_delete_presentacion_success(res,data){
		var test = Presentation.find(data['id']);
		Presentation.remove(test);
		Presentation.trigger("data_loaded")
	}


	function savePresentation(pres){
		pres._id = pres._id.$oid; 
		var p = new Presentation(pres);
		p.save();
	}

});



