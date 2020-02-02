<template>
  <div id='vcal'>
    <FullCalendar
      class='calendar-app'
      :defaultView="View"
      :locale="locale"
      :header="calendarHeader"
      :weekends="calendarWeekends"
      :plugins="calendarPlugins"
      :events="calendarEvents"
      @dateClick="handleDateClick"
    />
    <EventForm :dialog="toggleDialog" />
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

export default {
  name: 'Calendar',
  components: {
    FullCalendar, // make the <FullCalendar> tag available
    EventForm: form
  },
  data () {
    return {
      View: 'dayGridMonth',
      locale: jaLocale, // 日本語化
      // カレンダーヘッダーのデザイン
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
      calendarEvents:  [
        {
          title: 'Happy BirthDay!',
          start: '2020-02-26',
          allDay: 'true'
        }
      ],
      toggleDialog: false,
    }
  },
  methods: {
    handleDateClick (arg) {
      this.toggleDialog = true
      // if (confirm('新しいスケジュールを' + arg.dateStr + 'に追加しますか ?')) {
      //   this.calendarEvents.push({ // add new event data
      //     title: '新規スケジュール',
      //     start: arg.date,
      //     allDay: arg.allDay
      //   })
      // }
    }
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