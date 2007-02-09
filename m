From: eduardo@ctm.ulpgc.es (Eduardo Suarez)
Date: Fri, 09 Feb 2007 16:52:37 +0000
Subject: [lm-sensors] problem with i801
Message-Id: <45CCA6D5.2080603@ctm.ulpgc.es>
List-Id: <lm-sensors.vger.kernel.org>
References: <4586BC72.5080308@ctm.ulpgc.es>
In-Reply-To: <4586BC72.5080308@ctm.ulpgc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I don't understand how sensors work. Is there a way to tell not to test
the nvidia?

Jean Delvare escribi?:
> On Mon, 18 Dec 2006 16:06:10 +0000, Eduardo Suarez wrote:
>> Everything compiled fine. Computer hangs when i try sensors -s.
>> (...)
>> Dec 18 13:33:40 dogbert eeprom 3-0050: Starting eeprom update, slice 0
>> Dec 18 13:33:40 dogbert BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
>> (...)
>>     i2c-3       i2c             NVIDIA i2c adapter 2 at 1:00.0
>>     i2c-2       i2c             NVIDIA i2c adapter 1 at 1:00.0
>>     i2c-1       i2c             NVIDIA i2c adapter 0 at 1:00.0
>>     i2c-0       smbus           SMBus I801 adapter at 10c0
> 
> I replied to you in ticket #2158 already. The crash is obviously
> happening in the nvidia binary driver, so we can't help you. Go report
> your problem to Nvidia.
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3369 bytes
Desc: S/MIME Cryptographic Signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070209/77ec347f/attachment.bin 
