From: phil@philedelbrock.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: [sensors] system slow since ~ 2.6.7
Message-Id: <E717E5D4-3F2B-11D9-959F-000A95A4F536@philedelbrock.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.60.0411242139090.2319@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0411242139090.2319@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Nov 25, 2004, at 12:19 PM, Jean Delvare wrote:

>> (added Andrew to CC as he also answered my original email. Don't know
>> if sensors@stimpy.netroedge.com allows non-subscribers)
>
> Yes it does :) Now I hope acpi-devel does too.
>
>> This reminds me: about a year ago my CPU fan burnt down. Then too,
>> shortly after booting the PC, it slowed down. Then by accident I
>> noticed in BIOS CPU temperature 98 deg C. With a new fan problem
>> disappeared.
>
> Wow, 98, no less. You're lucky it didn't catch on fire, you know.
>
>> So, can it be, that the BIOS automatically slows down (throttles) the
>> CPU at high temperature.
>
> Yes this is certainly what happens. Blinking power led usually means
> that some kinf of thermal or power management is in effect.
>

The P4 will throttle itself when it gets too hot but at least some  
older Athlons won't without some external (bios?) monitoring.  Tom's  
Hardware made a great video a while back showing a P4 slowing down when  
getting too hot, and a couple Athlons going up in smoke @ 300 degrees C  
when the heatsinks were removed:

http://www4.tomshardware.com/cpu/20010917/heatvideo 
-05.html#download_the_first_toms_hardware_test_lab_video

They got a lot of heat for producing this video.  (pun intended)


Phil
