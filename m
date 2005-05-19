From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Sensors on K7S5A and kernel 2.6.1
Message-Id: <1075129257.40152ba90877c@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <401526A5.30908@st.com>
In-Reply-To: <401526A5.30908@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi, lm_sensors v2.8.3 and linux kernel 2.6.1 on mainboard K7S5A v3.1
> (chip type it87), after some trouble, works like a charm.
> (...)
> In the sysfs pseudo filesystem I can read the temperature values.
> So I made some modification to lib/chips.c to fix the trouble.
> You can see the diff file at the end of this e-mail.
> I had to change also the lines in sensors.conf
> #    from                    to
> #========================> #    set   temp2_hyst  20    set   temp2_min  20
> #    set   temp3_hyst  25    set   temp3_min  25

As stated on both our main page and our linux 2.6 specific page, it87
users should not use lm_sensors 2.8.3, because of the bug you spotted.
It is known and already fixed in CVS. Thanks for the report anyway.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
