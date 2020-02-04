<template>
  <div id='vcal'>
    <FullCalendar
      class='calendar-app'
      ref="calendar"
      :defaultView="View"
      :locale="locale"
      :header="calendarHeader"
      :weekends="calendarWeekends"
      :plugins="calendarPlugins"
      :events="calendarEvents"
      :timezone="calendarTime"
      :ignoreTimezone="ignore"
      @dateClick="handleDateClick"
    />
    <EventForm :dialog="toggleDialog" :eventStart="selectDay" @reloadEvent="reload"/>
  </div>
</template>

<script>
import FullCalendar from '@fullcalendar/vue'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import interactionPlugin from '@fullcalendar/interaction'
import jaLocale from '@fullcalendar/core/locales/ja' // 日本語化用
import form from './form.vue'
import '@fullcalendar/core/main.css'
import '@fullcalendar/daygrid/main.css'
import '@fullcalendar/timegrid/main.css'
import axios from 'axios'

export default {
  name: 'calendar',
  components: {
    FullCalendar,
    EventForm: form
  },
  data () {
    return {
      View: 'dayGridMonth',
      locale: jaLocale, // 日本語化
      calendarTime: 'local',
      ignore: true,
      calendarHeader: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay'
      },
      calendarWeekends: true, // 土日を表示するか
      // カレンダーで使用するプラグイン
      calendarPlugins: [ 
        dayGridPlugin,
        timeGridPlugin,
        interactionPlugin
      ],
      // カレンダーに表示するスケジュール一覧
      calendarEvents: [],
      toggleDialog: false,
      selectDay: ''
    }
  },
  methods: {
    handleDateClick (arg) {
      this.toggleDialog = false
      this.toggleDialog = true
      this.selectDay = arg.dateStr
      // if (confirm('新しいスケジュールを' + arg.dateStr + 'に追加しますか ?')) {
      //   this.calendarEvents.push({ // add new event data
      //     title: '新規スケジュール',
      //     start: arg.date,
      //     allDay: arg.allDay
      //   })
      // }
    },
    reload () {
      axios.get(`api/events`).then(res => {
        console.log("Reload Start!!")
        this.calendarEvents = res.data
        this.$refs.calendar.$emit('refetch-events')
      });
    }
  },
  created: function() {
    axios.get(`api/events`).then(res => {
      this.calendarEvents = res.data
    });
  }
}
</script>
<style>
@import '@fullcalendar/core/main.css';
@import '@fullcalendar/daygrid/main.css';
@import '@fullcalendar/timegrid/main.css';

.calendar-app {
  margin: 0 auto;
  min-height: 360px;
}

.fc-sun {
  color: red;
  background-color: #fff0f0;
}

.fc-sat {
  color: blue;
  background-color: #f0f0ff;
}

.fc table {
  min-height: 60px;
}

.fc-event {
  font-size: 1.25em;
}
  
.fc-day-grid-container.fc-scroller {
    height: auto!important;
    overflow-y: auto;
}
</style>