From: jbpn@cambridgebroadband.com (John Naylon)
Date: Mon, 23 May 2005 12:47:55 +0000
Subject: [lm-sensors] Memory leak in sensors_get_label()
Message-Id: <200505231046.j4NAkfU7029991@cambridgebroadband.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200505191529.j4JFTwG2024009@cambridgebroadband.com>
In-Reply-To: <200505191529.j4JFTwG2024009@cambridgebroadband.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

  thanks for looking at this.

khali@linux-fr.org said:
> Thanks a lot for looking into this. We know there are a few leaks in
> libsensors, most of which are in the configuration file parser, and none of
> us know how to fix them.

  Yes, sensors_parse_chip_name() definitely leaks memory too; however as
the file parsing stuff isn't usually called repeatedly, I'm less concerned
about this.

khali@linux-fr.org said:
> We can't blame you for not understanding how that code works. It's not
> exactly elegant, let alone the terrible coding style and lack of comments. 

  Well, I didn't want to say anything...!  In my experience, not using
braces for conditionals and (especially) loops usually leads to bugs, and
hard-to-spot ones at that.

khali@linux-fr.org said:
> Yes of course. Leaks are bad anyway, so let's kill that one. What tool are
> you using BTW? sensord? 

  No, we have a home-brew module that exports sensor information via 
SNMP.

khali@linux-fr.org said:
> I've attached my proposed patch. Please give it a try. If it works for you
> and nobody objects to the way it changes the function, I'll apply it to
> lm_sensors CVS. 

  I've given this a try, and it works without leaks.  It does change the
output -- we have a section like this in sensors.conf:

    label temp1       "CPU"
    set   temp1_over  55
    set   temp1_hyst  53

Previously we would get "temp1_hyst" returned as a label; now we just get 
"temp1_low".  This isn't a problem for us; is it what you would have expected
though?

khali@linux-fr.org said:
> And if you happen to spot other leaks ruining your embedded platforms,
> please let us know, and we'll try to hunt them down. 

  Will do!  Thanks again for your response.

John
-- 
Dr. John Naylon
Cambridge Broadband Ltd. // www.cambridgebroadband.com

