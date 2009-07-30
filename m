From: "Charles" <CharlesA@auroville.org.in>
Date: Thu, 30 Jul 2009 15:31:19 +0000
Subject: [lm-sensors] lm-sensors 3.0.0 init script lm-sensors -- what does
Message-Id: <200907301520.n6UFKAdS025340@rs49.luxsci.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello  :-)

The lm-sensors 3.0.0 init script "lm-sensors" runs only two significant
commands:

sensors -s 
sensors 
 
I understand the "sensors -s" activates any limits created by set statements
in sensors3.conf.  What happens (or could be configured to happen) if a
limit is exceeded?  The sensors.conf man page tells how to configure set
values but not what they do.

Why does the init script run sensors (discarding its output)?  Is this
necessary for initialisation before lmsensors library functions can be used?

In case the answers to these questions depend on hardware and lmsensors
library users, I am particularly interested in the it87 chip and GKrellM.

Best

Charles


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
