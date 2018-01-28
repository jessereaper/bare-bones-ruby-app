require 'rack'

require 'rack'

+def layout(page)
+  <<~HEREDOC
+    <!DOCTYPE html>
+    <html>
+      <head>
+        <meta charset="utf-8">
+        <meta name="viewport" content="width=device-width, initial-scale=1">
+        <title>The Simplest Ruby App</title>
+        <style type="text/css">
+          body{margin:40px auto;max-width:650px;line-height:1.6;font-size:18px;color:#444;padding:0 10px}
+          h1,h2,h3{line-height:1.2}
+        </style>
+      </head>
+      <body>
+        #{page}
+      </body>
+    </html>
+  HEREDOC
+end

app = Proc.new do |env|
  status = '200'
  puts env
  path = env['PATH_INFO'][1..-1]
  filename = if path == ""
               "index"
             elsif File.file?("views/#{path}.html")
               path
             else
               status ="404"
               "404"
             end
  page = File.read("views/#{filename}.html")

  [
    status,
    {'Content-Type' => 'text/html'},
    [layout(page)]
  ]
end

Rack::Handler.default.run app, :Port => ENV['PORT'] || 5678
