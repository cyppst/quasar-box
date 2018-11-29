docker stop quasar-box&&docker rm quasar-box&&docker build -t golfcomsci/quasar-box .&&docker run -d --name quasar-box -p 7484:7484 golfcomsci/quasar-box&&docker logs quasar-box -f
