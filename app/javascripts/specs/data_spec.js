describe('Frebbe Ajax Data Tests', function() {

	beforeEach(function() {
		app.test=true;
	});

	it('should load presentations from Ruby Test Spec' ,function (){
		var testVal = false;
		
		runs(function(){
			Presentation.bind("data_loaded",function(){
				testVal = true;
			});
		});
		
		waitsFor(function() {  
			return ( testVal == true );}	
			,"Login Error did not complete in 10 seconds", 10000
		);
		
		runs(function(){
			expect(Presentation.all().length).toBeGreaterThan(0);
		});
		
	});
	 

	it('should load presentations slides from last Presentation' ,function (){
		var p = Presentation.all();
		var id = p[0].id();
		var testVal = false;
		
			runs(function(){
				Presentation.bind("data_loaded",function(){
					testVal = true;
				});
				
				app.trigger('load_presentaciones',{id: id});
				
			});

			waitsFor(function() {  
				return ( testVal == true );}	
				,"Login Error did not complete in 10 seconds", 10000
			);

			runs(function(){
				expect(Presentation.all().length).toBeGreaterThan(1);
			});
	});

	it('should create a new presentation and add it to the model' ,function (){
			var p = Presentation.all();
			var id = p[0].id();
			var testVal = false;
			
		var slide = {site:"FROM JAVASCRIPT",titulo:"test",lineas:["uno","dos"],parentId:id,image:"/images/test.png",tags:["tag one","tag2","tag 3"]}
		app.trigger('save_presentacion',{slide: slide});
		
		runs(function(){
			Presentation.bind("data_loaded",function(){
				testVal = true;
			});
		});
		
			waitsFor(function() {  
				return ( testVal == true );}	
				,"Login Error did not complete in 10 seconds", 10000
			);

			runs(function(){
				expect(Presentation.all().length).toBeGreaterThan(2);
			});
		
	});

	it('should delete last created item from DB and Model' ,function (){
		var p = Presentation.all();
		var id = p[p.length -1].id();
		var testVal = false;
		
		app.trigger('delete_presentacion',{id: id});
	
		runs(function(){
			Presentation.bind("data_loaded",function(){
				testVal = true;
			});
		});
	
		waitsFor(function() {  
			return ( testVal == true );}	
			,"Login Error did not complete in 10 seconds", 10000
		);

		runs(function(){
			var before = p.length;
			p = Presentation.all();
			var after = p.length;
			expect(after).toBe < before
		});
		
	});





});
 

