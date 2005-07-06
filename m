From: mds@mds.gotdns.com (Mark Studebaker)
Date: Wed, 06 Jul 2005 21:36:46 +0000
Subject: [lm-sensors] Unsupported mBMC on Intel SE7320SP2
Message-Id: <42CC25AC.50602@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c58192$0cd0dc70$fe78a8c0@doppelhertz>
In-Reply-To: <000801c58192$0cd0dc70$fe78a8c0@doppelhertz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the newdrivers page does indeed have info on the 87431.

Sch?fer Raumgestaltung wrote:
> Chips on this Board:
>    
> Super-I/O National (now Winbond) PC 87427
> mBMC     National                        PC 87431
> 
> No Info available as i read in Section 'newdrivers' 
> 
> I found some 'Documentation' on INTEL Support CD (see partial Cut below)
> 
> if useful, please E-Mail  for further Data.......
> 
> hth
> 
> Uli
> 
> 
> //****************************************************************************
> 
> 
> //
> // File Header Information
> //
> 
> _LF_NAME       'SE7320SP2/SE7525GP2 SDR File'
> _LF_VERSION    '1.10'
> _LF_FMT_VER    '1.50'
> _IPMI_VERSION  '1.50'
> 
> //
> // SDR Header Information
> //
> 
> _SDR (
> _START_ADDR    0000
> _DATA_LEN      0000
> _NVS_TYPE      'IMBDEVICE'
> _DEV_BUS       FF
> _DEV_ADDRESS   20
> 
> 
> // ================================
> 
> ######################## Cut here '##########################################
> 
> // ================================
> //     CPU1 12V Sensor SDR entry (0Ah)
> // ================================
> 
> _SDR_TYPE      01
> _REC_LEN       0038
> 
>    // Sensor Record Header
>    000B               // Record ID
>    51                 // SDR Version
>    01                 // Record Type
>    33                 // Record Length
> 
>    // Record Key Bytes
>    20                 // Sensor Owner ID
>    00                 // Sensor Owner LUN
>    0A                 // Sensor Number
> 
>    // Record Body Bytes
>    07                 // Entity ID
>    01                 // Entity Instance
>    79                 // Sensor Initialization
>    68                 // Sensor Capabilities
>    02                 // Sensor Type
>    01                 // Event / Reading Base Type
>    8532               // Assertion Event Mask
>    8532               // Deassertion Event Mask
>    1B1B               // Reading Mask & Settable / Readable Threshold Masks
>    00                 // Sensor Units 1
>    04                 // Sensor Units 2
>    00                 // Sensor Units 3
>    00                 // Linearization
>    3E                 // M
>    00                 // M, Tolerance
>    60                 // B
>    00                 // B, Accuracy
>    00                 // Accuracy, Accuracy Exp
>    D0                 // R exp, B exp
>    07                 // Analog characteristic flags
>    C1                 // Nominal Reading
>    D2                 // Normal Maximum
>    B3                 // Normal Minimum
>    FF                 // Sensor Maximum Reading
>    00                 // Sensor Minimum Reading
>    00                 // Upper non-recoverable
>    D9                 // Upper critical
>    D3                 // Upper non-critical
>    00                 // Lower non-recoverable
>    AD                 // Lower critical
>    B2                 // Lower non-critical
>    02                 // Positive hysterisis value
>    02                 // Negative hysterisis value
>    00                 // Reserved
>    00                 // Reserved
>    00                 // OEM
>    C8                 // Type/Length Code
>    'CPU1 12V'         // String Bytes
> 
> 
> ######################## Cut here '##########################################
> 
> // ================================
> //     Proc1 VCCP Sensor SDR entry (15h)
> // ================================
> _SDR_TYPE      02
> _REC_LEN       002A
> 
>    // Sensor Record Header
>    0016               // Record ID
>    51                 // SDR Version
>    02                 // Record Type
>    25                 // Record Length
> 
>    // Record Key Bytes
>    20                 // Sensor Owner ID
>    00                 // Sensor Owner LUN
>    15                 // Sensor Number
> 
>    // Record Body Bytes
>    03                 // Entity ID
>    01                 // Entity Instance
>    79                 // Sensor Initialization
>    68                 // Sensor Capabilities
>    02                 // Sensor Type
>    03                 // Event / Reading Base Type
>    0100               // Assertion Event Mask
>    0100               // Deassertion Event Mask
>    0100               // Reading Mask & Settable / Readable Threshold Masks
>    C0                 // Sensor Units 1
>    00                 // Sensor Units 2
>    00                 // Sensor Units 3
>    0100               // Sensor Record Sharing
>    00                 // Positive-going Threshold Hysteresis
>    00                 // Negative-going Threshold Hysteresis
>    00                 // Reserved
>    00                 // Reserved
>    00                 // Reserved
>    00                 // OEM
>    CA                 // Type/Length Code
>    'Proc1 VCCP'       // String Bytes
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


