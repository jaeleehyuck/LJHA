package web.service.face;

import java.util.List;
import java.util.Map;

import web.dto.Cart;
import web.dto.Order;
import web.dto.ProdOption;
import web.dto.Product;
import web.util.Paging;

public interface GoodsService {

	public Paging getPaging(int curPage);

	/**
	 * 상품 목록 불러오기
	 * @param paging
	 * @return
	 */
	public List<Product> getgoodsList(Paging paging);

	
	/**
	 * 상품 디테일 정보 불러오기
	 * @param prodno
	 * @return
	 */
	public Map<String, Object> getProdDetail(int prodno);

	/**
	 * 장바구니에 넣기
	 * @param cart
	 */
	public void addCart(Cart cart);

	
	
	/**
	 * 유저넘버에 해당하는 장바구니 리스트 불러오기
	 * @param userNo
	 * @return
	 */
	public List<Map<String, Object>> getcartList(int userNo);

	/**
	 * 회원번호, 장바구니 번호와 일치하는 데이터 cart DTO에서 삭제하기
	 * 
	 * @param userNo - 로그인한 회원의 번호
	 * @param carttNo - 삭제하려는 장바구니의 번호
	 */
	public void deleteCartBySelect(int userNo, String cartNo);



	
	/**
	 *  상품 번호에 맞는 옵션 가져오기
	 * @param prodno
	 * @return
	 */
	public List<Map<String, Object>> getOptionList(int prodno);

	/**
	 * 주문정보 DB에 삽입하기
	 * 
	 * @param order - 주문정보가 담긴 DTO
	 */
	public void makeOrder(Order order);

	/**
	 * 전체주문 후 해당 회원번호의 장바구니 비우기
	 * 
	 * @param userNo
	 */
	public void deleteCart(int userNo);

	/**
	 * 회원번호와 일치하는 주문목록 리스트 불러오기
	 * 
	 * @param userNo - 로그인한 회원의 번호
	 * @return 회원의 주문목록 리스트
	 */
	public List<Order> orderList(int userNo);

	
	
}
