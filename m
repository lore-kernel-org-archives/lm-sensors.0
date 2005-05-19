From: jklaas@comcast.net (jklaas)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: smartbatt
Message-Id: <Pine.LNX.4.50.0309040816110.5758-100000@shenendoah.appalachian.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.50.0308211355310.11405-200000@shenendoah.appalachian.home>
In-Reply-To: <Pine.LNX.4.50.0308211355310.11405-200000@shenendoah.appalachian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I sent some mail last month about wanting to join the lm_sensors group.  
I've actually gotten my smartbatt driver working great.  I've even 
modified lib/chips.[ch] so that I can read the data.  I've kind of 
started on prog/sensors/chips.[ch] but that's kind of stalled at the 
moment.

Should I submit a patch for what I've done?  I was also looking at the 
built-in battery charger at 0x09 and I am considering starting a chip 
driver for that.

-- 
			James Klaas

Procrastinate NOW!!!! -- Don't put it off.
