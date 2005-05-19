From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: [patch] i2c-piix: Don't treat ServerWorks servers as Laptops
Message-Id: <40BAAE3C.3040203@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040529142325.GA14964@ucw.cz>
In-Reply-To: <20040529142325.GA14964@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks.
I checked it into CVS.

Vojtech Pavlik wrote:
> On Sun, May 30, 2004 at 01:12:15PM -0400, Mark Studebaker wrote:
> 
> 
>>you're sure that there are no serverworks chips in IBM laptops?
> 
> 
> Quite sure, yes. There's no checking for any other non-intel chipsets
> either, and the chance isn't bigger than for example a SiS chipset being
> in an IBM laptop.
> 
> 
>>Vojtech Pavlik wrote:
>>
>>>On Sun, May 30, 2004 at 11:21:30AM +0200, Jean Delvare wrote:
>>>
>>>
>>>>>I'm sending you this little obvious patch which should enable i2c-piix
>>>>>to work on IBM servers with ServerWorks chipsets. It still will treat
>>>>>any IBM/Intel machine as a laptop and refuse to work, but it's better
>>>>>than before.
>>>>
>>>>Fine with me. Note that the whole thing will hopefully disappear soon in
>>>>2.6 anyway. OTOH a similar "fix" would be welcome for 2.4 since I don't
>>>>plan to to the big change there.
>>>
>>>It should patch against 2.4 quite easily, too.
> 
> 
