var app = angular.module("myApp", ["ngRoute", "controllers",'bixApp'])

.config(function($routeProvider){

/*
		{ 
			path :"/",
			template: "/views/"
			,controller: ""
		}
*/
	var routeArray = [
		{ 
			path :"/manage_users",
			template: "views/manage_users.html"
		}
		,{ 
			path :"/manage_streams",
			template: "views/manage_streams.html"
		}
		,{ 
			path :"/manage_roles",
			template: "views/manage_roles.html"
		}
		,{ 
			path :"/add_teacher",
			template: "views/add_teacher.html"
			,controller: "TeacherController"
		}
		,{ 
			path :"/add_student",
			template: "/views/add_student.html"
			,controller: "StudentController"
		}
		,{ 
			path :"/add_classes",
			template: "/views/add_classes.html"
		}
		,{ 
			path :"/view_teacher",
			template: "views/view_teacher.html"
		}
		,{ 
			path :"/view_student",
			template: "views/view_student.html"
		}
	];

	$routeProvider
	.when("/", {
		templateUrl: "views/index.html"
	});

	routeArray.forEach(function(routeData){
		$routeProvider
		.when( routeData.path, {
			templateUrl: routeData.template,
			controller: routeData.controller 
		});
	});

		// .when("/manage_streams",{
		// 	templateUrl: "views/manage_streams.html"
		// })
		// .when("/manage_users",{
		// 	templateUrl: "views/manage_users.html"
		// })
		// .when("/manage_roles",{
		// 	templateUrl: "views/manage_roles.html"
		// })
		// .when("/add_teacher", {
		// 	templateUrl: "views/add_teacher.html",
		// 	controller: "TeacherController"
		// })
        // .when("/add_student", {
		// 	templateUrl: "views/add_student.html",
		// 	controller: "StudentController"
		// })
        // .when("/add_classes", {
		// 	templateUrl: "views/add_classes.html"
		// })
        // .when("/view_teacher", {
		// 	templateUrl: "views/view_teacher.html"
		// })
        // .when("/view_student", {
		// 	templateUrl: "views/view_student.html"
		// })
		$routeProvider.otherwise({
			templateUrl: "views/404.html"
		});
})