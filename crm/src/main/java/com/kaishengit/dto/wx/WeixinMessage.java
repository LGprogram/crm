package com.kaishengit.dto.wx;

/**
 * Created by liu on 2017/3/22.
 */
public class WeixinMessage {


    /**
     * touser : UserID1|UserID2|UserID3
     * toparty :  PartyID1 | PartyID2
     * msgtype : text
     * agentid : 1
     * text : {"content":"Holiday Request For Pony(http://xxxxx)"}
     */

    private String touser;
    private String toparty;
    private String msgtype="text";
    private int agentid=2;
    private TextBean text;

    public String getTouser() {
        return touser;
    }

    public void setTouser(String touser) {
        this.touser = touser;
    }

    public String getToparty() {
        return toparty;
    }

    public void setToparty(String toparty) {
        this.toparty = toparty;
    }

    public String getMsgtype() {
        return msgtype;
    }

    public void setMsgtype(String msgtype) {
        this.msgtype = msgtype;
    }

    public int getAgentid() {
        return agentid;
    }

    public void setAgentid(int agentid) {
        this.agentid = agentid;
    }

    public TextBean getText() {
        return text;
    }

    public void setText(TextBean text) {
        this.text = text;
    }

    public static class TextBean {
        /**
         * content : Holiday Request For Pony(http://xxxxx)
         */

        private String content;

        public String getContent() {
            return content;
        }

        public void setContent(String content) {
            this.content = content;
        }
    }
}
