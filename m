From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: 2.6.4 works, CVS broken...
Message-Id: <3DECF2A8.70401@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200212022319.gB2NJF51001794@orion.dwf.com>
In-Reply-To: <200212022319.gB2NJF51001794@orion.dwf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


BTW- If it hasn't already been mentioned, make sure your libsensors, 
sensors binary, and sensors.conf are updated appropriately along with 
any kernel modules/code you use.  I suspect that some of the strange 
decimal point shifts or mangled data can be a result of mixing an old 
install with a new.


Phil

Jean Delvare wrote:

>>With lm_sensors-2.6.4 and a 2.4.19 kernel things work as well as one
>>can expect with the as99127f (the temperatures are WRONG, but the code
>>at least works)
>>    
>>
>
>Could you try 2.6.5 and tell us if it work?
>
>  
>
