From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 29 Jan 2013 20:01:36 +0000
Subject: Re: [lm-sensors] tap SMBus vis PCI slot?
Message-Id: <20130129210136.2028e6c0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAEGEQC+-T34gofYjZyGZ-NQtJK+smUghtbLXx-h5GgMbqO2FVQ@mail.gmail.com>
In-Reply-To: <CAEGEQC+-T34gofYjZyGZ-NQtJK+smUghtbLXx-h5GgMbqO2FVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 29 Jan 2013 19:25:01 +0100, Robert Smith wrote:
> Quick update..
> 
> I successfully connected my Arduino UNO via the SMBus pins in the PCI slot
> today and used the Arduino Wire library to read temperatures from the
> motherboard's aSC7621. I checked the readings against speedfan and they
> matched.
> 
> It was only left running for a few minutes but I'm optimistic that it will
> work ok long term, the manual for the ICH10R states that the SMBus master
> is capable of multi mastering as is the Arduino.
> 
> If anyone needs to access their motherboard's SMBus then this might be a
> good solution. It seems that PCIe slots also have pins for SMBus (not sure
> if they are regularly connected?) and if you have a spare slot then then
> the riser card makes for an extremely simple non invasive connection.

Thanks for the update, I have updated the wiki to mention this option.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
