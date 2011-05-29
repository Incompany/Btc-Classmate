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
				var temp = JSON.parse(data);
				var count = temp.length -1;
				while (count>-1){
					var t = temp[count];
					var presentation = new Presentation(t);
					presentation.save();
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
			var p = new Presentation(original);
		}
		

	});



