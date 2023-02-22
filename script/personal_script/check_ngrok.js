const fetch = require('node-fetch')
fetch('http://localhost:4040/api/tunnels')
  .then(res => res.json())
  .then(json => json.tunnels.map(tunnel => tunnel.public_url))
  .then(publicUrls => publicUrls.forEach(url => console.log(url)))
  .catch(err => {
    if (err.code === 'ECONNREFUSED') {
      return console.error(
        "Looks like you're not running ngrok."
      )
    }
    console.error(err)
  })
