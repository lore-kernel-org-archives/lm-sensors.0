From: tebbens@yahoo.com (Mathew Tebbens)
Date: Fri, 30 Jun 2006 16:26:17 +0000
Subject: [lm-sensors] Support for Intel 82801GR (ICH7 Family)
Message-Id: <20060630162617.2388.qmail@web56514.mail.re3.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A125CA.3000603@correiolivre.serpro.gov.br>
In-Reply-To: <44A125CA.3000603@correiolivre.serpro.gov.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 
  The system is a Dell XPS GEN 5, and the dell mobo part number is GC068.
  I cannot find anymore information about it.
   
  I'm going to try with the latest sensors-detect and post here the results.
   
  Matthew
  

"andre.dantas-vieira at serpro.gov.br" <andre.dantas-vieira at correiolivre.serpro.gov.br> wrote:
  My motherboard is a Intel? Desktop Board D945GCZ 
. And i 
also re-tryed with the latest sensor-detect and didn't work.

Thanks for all,
Andre.

Rudolf Marek escreveu:

>Mathew Tebbens wrote:
> 
>
>>I'm also running the same chipset
>>lm_sensors is not working for me also.
>> 
>>
>
>Hmm strange.
>
> 
>
>>Next adapter: SMBus I801 adapter at ece0
>>Do you want to scan it? (YES/no/selectively): YES
>>Client found at address 0x08
>>Client found at address 0x30
>>Client found at address 0x31
>>Client found at address 0x32
>>Client found at address 0x33
>>Client found at address 0x44
>>Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
>>Client found at address 0x50
>>Probing for `SPD EEPROM'... Success!
>> (confidence 8, driver `eeprom')
>>Probing for `DDC monitor'... Failed!
>>Probing for `Maxim MAX6900'... Failed!
>>Client found at address 0x51
>>Probing for `SPD EEPROM'... Success!
>> (confidence 8, driver `eeprom')
>>Client found at address 0x52
>>Probing for `SPD EEPROM'... Success!
>> (confidence 8, driver `eeprom')
>>Client found at address 0x53
>>Probing for `SPD EEPROM'... Success!
>> (confidence 8, driver `eeprom')
>>Client found at address 0x69
>> 
>>
>
>This means that the bus is working. But there are no interresting devices on the
>bus.
>
>
>Andre and Mathew, what model/brand is your motherboard?
>
>Can you re-try with the latest sensors-detect?
>
>http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
>
>Save this file, and change the file permissions to exect or run as:
>
>perl ./sensors-detect
>
>Regards
>Rudolf
>
>
>
> 
>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060630/9294ce5a/attachment.html 
