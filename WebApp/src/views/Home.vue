<template>
  <div>
    <Navbar />
    <div class="container mt-5">

      <h1 class="text-center">Mes évènements</h1>
      <div class="text-center mb-3">
        <a href="#">Mes évènements</a> -
        <a href="#">Mes évènements partagés</a>
      </div>

      <div class="row">
        <div class="col-7">
          <div class="card mb-3">
            <l-map v-if="showMap" :zoom="zoom" :center="center" :options="mapOptions" style="height: 350px; width: 100%;"
              @update:center="centerUpdate" @update:zoom="zoomUpdate">
              <l-tile-layer :url="url" :attribution="attribution" />
              <l-marker :lat-lng="withTooltip">
                <l-tooltip :options="{ permanent: true, interactive: true }">
                  <div @click="innerClick">
                    {{ location.name }}
                    <p v-show="showParagraph">
                      Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque
                      sed pretium nisl, ut sagittis sapien. Sed vel sollicitudin nisi.
                      Donec finibus semper metus id malesuada.
                    </p>
                  </div>
                </l-tooltip>
              </l-marker>
            </l-map>
            <div class="card-body">
              <h5 class="card-title">{{ title }}</h5>
              <p class="card-text">{{ description }}</p>
              <p class="card-text"><small class="text-muted"><font-awesome-icon icon="calendar-alt"></font-awesome-icon> Prévu le {{ date }} par {{ author }}</small></p>
            </div>
          </div>
        </div>
        <div class="col-5">
          <div v-for="(event, index) in events" class="list-group">
            <a @click="selectEvent(event.title, event.description, event.date, event.author, event.location, index)" href="#" class="list-group-item list-group-item-action">
              <div class="d-flex w-100 justify-content-between">
                <h5 class="mb-1">{{ event.title }}</h5>
                <small><font-awesome-icon icon="map-marker-alt"></font-awesome-icon> {{ event.location.name }}</small>
              </div>
              <p class="mb-1">{{ event.description }}</p>
              <small><font-awesome-icon icon="calendar-alt"></font-awesome-icon> Prévu le {{ event.date }}</small>
            </a>
          </div>
          <div class="d-grid gap-2">
            <button class="btn btn-primary" type="button">Créer un nouvel évènement</button>
          </div>
        </div>
      </div>

    </div>
  </div>
</template>

<style lang="scss">
</style>

<script>
import Navbar from '@/components/Navbar.vue';
import { latLng } from "leaflet";
import { LMap, LTileLayer, LMarker, LTooltip } from "vue2-leaflet";
import { Icon } from 'leaflet';
import 'leaflet/dist/leaflet.css';

delete Icon.Default.prototype._getIconUrl;
Icon.Default.mergeOptions({
  iconRetinaUrl: require('leaflet/dist/images/marker-icon-2x.png'),
  iconUrl: require('leaflet/dist/images/marker-icon.png'),
  shadowUrl: require('leaflet/dist/images/marker-shadow.png'),
});

export default {
  components: {
    Navbar,
    LMap,
    LTileLayer,
    LMarker,
    LTooltip
  },

  data() {
    return {
      events: [],
      index: false,
      title: false,
      description: false,
      date: false,
      author: false,
      location: false,

      zoom: 15,
      center: latLng(location.x, location.y),
      url: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors',
      withTooltip: latLng(47.41422, -1.250482),
      currentZoom: 15,
      currentCenter: latLng(location.x, location.y),
      showParagraph: false,
      mapOptions: {
        zoomSnap: 0.5
      },
      showMap: true
    }
  },
  methods: {
    selectEvent(title, description, date, author, location, index) {
      this.index = index;
      this.title = title;
      this.description = description;
      this.date = date;
      this.author = author.fullname;
      this.location = location;
      this.center = latLng(location.x, location.y)
      this.currentCenter = latLng(location.x, location.y)
      this.withTooltip = latLng(location.x, location.y)
    },
    zoomUpdate(zoom) {
      this.currentZoom = zoom;
    },
    centerUpdate(center) {
      this.currentCenter = center;
    },
    showLongText() {
      this.showParagraph = !this.showParagraph;
    },
    innerClick() {
      alert("Click!");
    }
  },
  mounted() {
    api.get('events').then(response => {
        this.title = response.data.owned[0].title;
        this.description = response.data.owned[0].description;
        this.date = response.data.owned[0].date;
        this.author = response.data.owned[0].author.fullname;
        this.location = response.data.owned[0].location;
        this.center = latLng(response.data.owned[0].location.x, response.data.owned[0].location.y)
      this.currentCenter = latLng(response.data.owned[0].location.x, response.data.owned[0].location.y)
        this.withTooltip = latLng(response.data.owned[0].location.x, response.data.owned[0].location.y)
        response.data.owned.forEach(element => {
          this.events.push(element);
        });
    });
  }
}
</script>
