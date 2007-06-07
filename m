From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Jun 2007 08:39:07 +0000
Subject: Re: [lm-sensors] SMBus busy in 82801
Message-Id: <20070607103907.7828e8b7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <83016ef2d6c5b96b0c5c7e258f1a7f40d71edc69@localhost>
In-Reply-To: <83016ef2d6c5b96b0c5c7e258f1a7f40d71edc69@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Patrick,

On Wed, 6 Jun 2007 09:39:52 -0700, Patrick Connolly wrote:
> We cannot get the lm-sensors user-space adapter to work on our embedded
> system.  Problem seems to be localized to the Intel 82801 Southbridge.
>  
> SHORT DESCRIPTION
> We are trying to read an eeprom located on the SMBus ( using
> i2c_smbus_read_byte_data() ).  Debug messages from the driver show that
> the SMBus is busy (or not ready to Transmit).  However there is other
> debug output just before the busy-check which shows some important host
> registers to have all FF's in them; this seems to be abnormal.  We have
> not used "sensors-detect"; it is a perlscript and getting perl onto our
> embedded system would be quite ungainly.  
>  
> Any help would be appreciated.  Details, souce code, and kernel config
> are below.

Given that you don't seem to be interested in hardware monitoring, you
picked the wrong mailing list. The i2c mailing list would be much
better to discuss your problem:
http://lists.lm-sensors.org/mailman/listinfo/i2c

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
