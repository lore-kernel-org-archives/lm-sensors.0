From: <samu.p.onkalo@nokia.com>
Date: Tue, 03 Nov 2009 12:30:07 +0000
Subject: Re: [lm-sensors] [RFC PATCH 09/10] lis3: Scale output values to mg
Message-Id: <62697B07E9803846BC582181BD6FB6B8256DACE233@NOK-EUMSG-02.mgdnok.nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257250185-7929-10-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1257250185-7929-10-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 

>-----Original Message-----
>From: ext Daniel Mack [mailto:daniel@caiaq.de] 
>Sent: 03 November, 2009 14:17
>To: Onkalo Samu.P (Nokia-D/Tampere)
>Cc: eric.piel@tremplin-utc.net; kalhan.trisal@intel.com; 
>lm-sensors@lm-sensors.org
>Subject: Re: [RFC PATCH 09/10] lis3: Scale output values to mg
>
>On Tue, Nov 03, 2009 at 02:09:44PM +0200, Samu Onkalo wrote:
>> Report output values as 1/1000 of earth gravity.
>
>Without having tried that, I assume that changes the values 
>for all events reported? That would break all userspace 
>clients of this device, right?
>

Yes. That is one thing which need to agreed here. One possibility is to
implement this as a configurable feature for example using platform data.
In that kind of solution default value must be the old way.

-Samu

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
