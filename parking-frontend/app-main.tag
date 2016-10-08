<app-main>

  <article>
    <h1>{ title }</h1>
    <p>{ body }</p>
    <a if={ isDetail } href="/first">Back</a>
    <ul if={ isFirst }>
      <li each={ data }><a href="/first/{ id }">{ title.slice(1,8); }</a></li>
    </ul>
  </article>
  <script src="https://code.jquery.com/jquery-1.10.2.js"></script>

  <script>
    var self = this
    self.title = 'Now loading...'
    self.body = ''

    // self.data = [
    //   { id: 'apple', title: 'Apple', body: "The world biggest fruit company." },
    //   { id: 'orange', title: 'Orange', body: "I don't have the word for it..." }
    // ]
    // jQuery.getJSON( "https://jsonplaceholder.typicode.com/posts", function( results ) {
    //   self.data =  results;
    // });

    this.on('mount', function(){
      jQuery.getJSON( "https://jsonplaceholder.typicode.com/posts", function( results ) {
        self.data =  results;
      });
    });

    var r = riot.route.create()
    r('/',       home       )
    r('first',   first      )
    r('first/*', firstDetail)
    r('second',  second     )
    r(           home       ) // `notfound` would be nicer!

    function home() {
      self.update({
        title:  "Home of the great app",
        body:  "Timeline or dashboard as you like!",
        isFirst: false
      })
    }
    function first() {
      self.update({
        title: "First feature of your app",
        body: "It could be a list of something for example.",
        isFirst: true
      })
    }
    function firstDetail(id) {
      var selected = self.data.filter(function(d) { return d.id == id })[0] || {}
      self.update({
        title: selected.title,
        body: selected.body,
        isFirst: false,
        isDetail: true
      })
    }
    function second() {
      self.update({
        title: "Second feature of your app",
        body: "It could be a config page for example.",
        isFirst: false
      })
    }
  </script>

  <style scoped>
    :scope {
      display: block;
      font-family: sans-serif;
      margin-right: 0;
      margin-bottom: 130px;
      margin-left: 50px;
      padding: 1em;
      text-align: center;
      color: #666;
    }
    ul {
      padding: 10px;
      list-style: none;
    }
    li {
      display: inline-block;
      margin: 5px;
    }
    a {
      display: block;
      background: #f7f7f7;
      text-decoration: none;
      width: 150px;
      height: 150px;
      line-height: 150px;
      color: inherit;
    }
    a:hover {
      background: #eee;
      color: #000;
    }
    @media (min-width: 480px) {
      :scope {
        margin-right: 200px;
        margin-bottom: 0;
      }
    }
  </style>

</app-main>
