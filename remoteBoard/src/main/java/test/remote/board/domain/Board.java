package test.remote.board.domain;

import lombok.Data;

@Data
public class Board {
	int id;
	String error_type;
	String sector;
	String text3;
	String text4;
	String device_id;
	
	/*// 페이징 구현
    private static int offset;
    private static int listCount;

    public static int getOffset() {
        return offset;
    }

    public static void setOffset(int offset) {
    	Board.offset = offset;
    }

    public static int getListCount() {
        return listCount;
    }

    public static void setListCount(int listCount) {
    	Board.listCount = listCount;
    }*/
}
