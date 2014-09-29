##Description

[Coull.com](http://coull.com)'s *very* simple [Dashing](http://shopify.github.com/dashing) widget to display a [Graphite](http://graphite.wikidot.com/) graph with the correct dimensions and auto-refresh it every so often.

##Usage

Copy `graphite.scss`, `graphite.html` and `graphite.coffee` into `widgets/graphite`.

In your dashboard, add a snippet such as this:

    <li data-row="1" data-col="1" data-sizex="2" data-sizey="1">
      <div data-view="Graphite" data-image="http://my.graphite.instance.com/render?from=-3hours&amp;width=600&amp;height=400&amp;target=my.graphite.metric&amp;_uniq=0.11581272282637656" data-interval="60000"></div>
    </li>

The `data-image` attribute should be set to a graphite image URL. Don't worry about the width, height and uniq paramters - they'll be replaced by the javascript based on your dashboard settings. `data-interval` may be set to indicate the number of milliseconds between refreshes of the graph. If omitted, it will default to 60,000 (1 minute).