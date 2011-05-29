describe('Frebbe Ajax Data Tests', function() {

	beforeEach(function() {
		app.test=true;
	});

	it('should load presentations from Ruby Test Spec' ,function (){
	//	var slide = {site:"test",titulo:"test",lineas:["uno","dos"],parentId:"",image:"/images/test.png",tags:["tag one","tag2","tag 3"]}
		//app.trigger('save_presentacion',{slide: slide});
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
	 




});
 

