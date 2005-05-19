From: david.goodenough@btconnect.com (David Goodenough)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: Support of i2c-nscacb
Message-Id: <200504181437.33041.david.goodenough@btconnect.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4263B107.1070703@buholzer.com>
In-Reply-To: <4263B107.1070703@buholzer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Monday 18 April 2005 14:07, Mirko Buholzer wrote:
> Hi all
>
> I am new to this mailing list and also to the LM_Sensors package. I have
> a WRAP Embedded System (http://www.pcengines.ch/) which is based on the
> GEODE SC1100 and the i2c-nscacb.c driver from National. I saw, that
> there were some discussions in this mailing list about this driver 6
> months ago, but couldn't find further information about the support of
> this Bus Driver. Is there already some work going on or is there a way
> to contribute to enable this chip?
>
> Thanks in advance for any information!
> Best Regards
> Mirko
>
> BTW: How can I subscribe to this list?

If you are using a 2.6 kernel then the scx200_acb driver is the one you
need.  The iscacb driver is obsolete.  The lm87 driver then does the 
sensing.

I am using it on several WRAP boards.

David
