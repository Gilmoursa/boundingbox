##Bounding Box API

 - converts a series of comma separated dimensions into dimensions that fit within a bounding box

##Installation

 - clone the repo
 - enter the directory and run `rails s` or `rails server`
 - open your browser
 - navigate to `http://localhost:3000`

##Use

 - Enter a url with dimension parameters into your browser
 	- ex: `http://localhost:3000/api/v1/aspect?image_dimensions=[1256,1200,600,800,200,200,400,200,800,1256]&bounding_box=[200,200]`
 - The api will return a response
 	```{
scaled_dimensions: [
200,
191,
150,
200,
200,
200,
200,
100,
127,
200
],
bounding_box: [
200,
200
]
}```