From: jbpn@cambridgebroadband.com (John Naylon)
Date: Mon, 23 May 2005 14:07:38 +0000
Subject: [lm-sensors] Memory leak in sensors_get_label()
Message-Id: <200505231206.j4NC6sU7001682@cambridgebroadband.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200505191529.j4JFTwG2024009@cambridgebroadband.com>
In-Reply-To: <200505191529.j4JFTwG2024009@cambridgebroadband.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

khali@linux-fr.org said:
> > No, we have a home-brew module that exports sensor information via
> > SNMP.
> Is there somewhere other users could download this module? We had several
> users complaining about the lack of SNMP integration in lm_sensors, maybe
> what you wrote could be of some help to them. 

  This specific module is very application-specific, so it's unlikely to be
of much use to anyone else.  However, I am a member of the Net-SNMP project,
and sensor-related things are happening there, so watch this space.

khali@linux-fr.org said:
> Not really, I have to admit I am surprised, especially since I did not
> modify that very part of the code. Could you please verify that the patch
> itself, and not a version change (2.9.1 vs. CVS maybe?) causes the change in
> the output? I know we did fix a number of low limit vs. hysteresis name
> issues some times ago, this would more likely be related. 

  You are quite correct -- my mistake.  The patch *does not* cause any 
changed in output; I was comparing against a much older version.

John
-- 
Dr. John Naylon
Cambridge Broadband Ltd. // www.cambridgebroadband.com

