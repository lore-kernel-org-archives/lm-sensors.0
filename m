From: hans@rubico.se (Hans Eklund)
Date: Fri, 03 Nov 2006 08:04:29 +0000
Subject: [lm-sensors] DS2450 1-wire family driver
Message-Id: <200611030904.29206.hans@rubico.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.

We are a team working with uClinux for Blackfin DSPs and sensor networking, we 
are currently in the stadium of investigating Linux capabilites on sensors 
over i2c and 1-wire buses. I have been assigned to try out the DS2450 quad 
A/D converter(1-wire slave device):

http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2921

I Tried to search the lm-sensors list archive but could not find any related 
drivers. Has there been any work on that family? I guess that it would need a 
family driver. If non existent i will write one over the next week. Would the 
community be interested in the driver? I think it could be quite useful for 
connecting a wide variety of sensors to it.

regards

/Hans Eklund
www.rubico.se

