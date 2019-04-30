{% if theme.gitment.enable %}
    {% set id = page.number %}
    {% set owner = theme.gitment.githubID %}
    {% set repo = theme.gitment.repo %}
    {% set cid = theme.gitment.ClientID %}
    {% set cs = theme.gitment.ClientSecret %}
    
    {% if id %}
        <link rel="stylesheet" href="{{ url_for(theme.css) }}/src/gitment.css">
        <script type="text/javascript" src="{{ url_for(theme.js) }}/src/gitment.browser.js"></script>
        {% if not theme.gitment.lazy %}
            <script type="text/javascript">
                var gitment = new Gitment({
                    id: '{{id}}', 
                    owner: '{{owner}}',
                    repo: '{{repo}}',
                    oauth: {
                        client_id: '{{cid}}',
                        client_secret: '{{cs}}'
                    }});
                gitment.render('gitment-container');
            </script>
        {% else %}
            <script type="text/javascript">
                function ShowGitment(){
                    document.getElementById("gitment-display-button").style.display = "none";
                    document.getElementById("gitment-container").style.display = "block";
                    var gitment = new Gitment({
                        id: '{{id}}', 
                        owner: '{{owner}}',
                        repo: '{{repo}}',
                        oauth: {
                            client_id: '{{cid}}',
                            client_secret: '{{cs}}',
                        }});
                    gitment.render('gitment-container');
                }
            </script>
        {% endif %}
    {% endif %}
 {% endif %}