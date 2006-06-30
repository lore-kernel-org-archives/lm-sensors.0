From: andre.dantas-vieira@correiolivre.serpro.gov.br (andre.dantas-vieira@serpro.gov.b
Date: Fri, 30 Jun 2006 11:49:11 +0000
Subject: [lm-sensors] Support for Intel 82801GR (ICH7 Family)
Message-Id: <44A50FB7.9030308@correiolivre.serpro.gov.br>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A125CA.3000603@correiolivre.serpro.gov.br>
In-Reply-To: <44A125CA.3000603@correiolivre.serpro.gov.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

My motherboard is a Intel? Desktop Board D945GCZ 
<http://www.intel.com/products/motherboard/d945gcz/index.htm> . And i 
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
>>    (confidence 8, driver `eeprom')
>>Probing for `DDC monitor'... Failed!
>>Probing for `Maxim MAX6900'... Failed!
>>Client found at address 0x51
>>Probing for `SPD EEPROM'... Success!
>>    (confidence 8, driver `eeprom')
>>Client found at address 0x52
>>Probing for `SPD EEPROM'... Success!
>>    (confidence 8, driver `eeprom')
>>Client found at address 0x53
>>Probing for `SPD EEPROM'... Success!
>>    (confidence 8, driver `eeprom')
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

