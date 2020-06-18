from flask import Flask,render_template,request,session,redirect,jsonify
from  DBConnection import Db
import random
db=Db()
app = Flask(__name__)
app.secret_key='adc'

static_path="C:\\Users\\Ammar Abdul Aziz\\Desktop\\Hilton Hotel\\hotel\\static\\"

# static_path="C:\\ab_encry\\static\\"

@app.route('/')
def log():
    return render_template('Login.html')

@app.route('/login,<lid>')
def login(lid):
    session['id']=lid
    qr="select * from login where login_id='"+str(session['id'])+"'"
    db=Db()
    res = db.selectOne(qr)
    return log()

@app.route('/login_page',methods=["post"])
def login_page():
    db=Db()
    username=request.form['username']
    password=request.form['password']
    type=""
    qr="select * from login where username='"+username+"' and password='"+password+"'"
    res=db.selectOne(qr)
    if res is not None:
        type=res['type']
        session['id']=res['login_id']
        session['typeu']=res['type']
        if type=="admin":
            return redirect('/adm_Homepage')
        elif type=="manager":
            return redirect('/ManagerHomepage')
        elif type=="waitor":
            return redirect('/WaitorHomepage')
        elif type=="transport":
            return redirect('/TransportHomepage')
        elif type=="billing":
            return redirect('/BillingHomepage')
        else:
            return "Invalid Username or Password"
    else:
        return "Invalid Username or Password"


@app.route('/adm_Homepage')
def adm_Homepage():
    if session['id']:
        if session['typeu']=="admin":
            return render_template("Admin/index2.html")


        else:
            return 'Session Timeout'
    else:
        return 'Session Timeout'

@app.route('/logout')
def logout():
    session['id']=""
    session['typeu']=""
    return redirect('/')


@app.route('/adm_add_food')
def adm_add_food():
    db=Db()
    qry="select * from category"
    res=db.select(qry)
    return render_template("admin/add food items.html",data=res)

@app.route('/add_foods',methods=['post'])
def add_foods():
    foodname=request.form['textfield']
    price=request.form['textfield2']
    category=request.form['select']
    img=request.files['pic']
    desc = request.form["des"]
    img.save(static_path+"food\\"+img.filename)
    path="/static/food/"+img.filename
    qry="insert into food_items(food_name,price,category_id,picture,description)values('"+foodname+"','"+price+"','"+category+"','"+path+"','"+desc+"')"
    res=db.insert(qry)
    return adm_add_food()

@app.route('/adm_add_service')
def adm_add_service():
    return render_template("admin/add service.html")

@app.route('/add_services',methods=['post'])
def add_services():
    name=request.form['textfield']
    description=request.form['textfield2']
    qry="insert into service(name,description)values('"+name+"','"+description+"')"
    res=db.insert(qry)
    return adm_add_service()




@app.route('/adm_add_spl_food_item')
def adm_add_spl_food_item():
    qry = "select * from category"
    res = db.select(qry)
    return render_template("admin/add special food items.html",data=res)

@app.route('/spl_food',methods=['post'])
def spl_food():
    foodname=request.form['textfield']
    day=request.form['select']
    price=request.form['textfield2']
    category=request.form['select2']
    descr=request.form['descr']

    img = request.files['pic']
    img.save(static_path+"food\\" + img.filename)
    path = "/static/food/" + img.filename
    qry = "insert into spl_food(description,spl_food_name,price,week,category_id,picture)values('"+descr+"','" + foodname + "','" + price + "','" + day + "','" + category + "','" + path + "')"
    res = db.insert(qry)
    return adm_add_spl_food_item()





@app.route('/adm_view_spl_food_item')
def adm_view_spl_food_item():
    qr = "select special_food_id,spl_food_name,price,week,picture,category.category_name,spl_food.description from spl_food INNER JOIN category ON category.category_id=spl_food.category_id"
    db = Db()
    res = db.select(qr)
    return render_template("admin/view special food items.html",values=res)

@app.route('/adm_view_spl_food_items_delete/<fid>')
def adm_view_spl_food_items_delete(fid):
    qr = "delete from spl_food where special_food_id='"+fid+"'"
    db = Db()
    res = db.delete(qr)
    return adm_view_spl_food_item()

@app.route('/adm_view_spl_food_items_edit/<fid>')
def adm_view_spl_food_items_edit(fid):
    session['fid']=fid
    qr ="select special_food_id,spl_food_name,description,price,week,picture,category.category_name,category.category_id from spl_food INNER JOIN category ON category.category_id=spl_food.category_id where special_food_id='" + fid + "' "
    db = Db()
    res = db.selectOne(qr)

    qr2 = "select * from category"

    res2 = db.select(qr2)

    return render_template("Admin/edit special food items.html",data=res,cat=res2)


@app.route('/spl_food_items_edit',methods=['post'])
def spl_food_items_edit():
    print("mmss")
    fid = session['fid']
    splfoodname=request.form['textfield']
    price=request.form['textfield2']
    day=request.form['ss']
    category=request.form['s']
    descr=request.form['descr']
    print("uuu")

    qry="update spl_food set spl_food_name='"+splfoodname+"',description='"+descr+"',price='"+price+"',category_id='"+category+"',week='"+day+"'"
    print(qry)
    if request.files is not None:
        if 'photo' in request.files:
            photo=request.files['photo']
            if photo.filename!="":
                photo.save(static_path+"food\\"+photo.filename)
                path='/static/food/'+photo.filename
                qry=qry+",picture='"+path+"'"
    else:
        return 'no'
    qry=qry+" where special_food_id='"+str(fid)+"'"
    print(qry)
    res=db.update(qry)
    return adm_view_spl_food_item()




@app.route('/adm_add_staff')
def adm_add_staff():
    return render_template("admin/add staff.html")

@app.route('/add_staff',methods=['post'])
def add_staff():
    staffname=request.form['textfield']
    img = request.files['pic']
    dob=request.form['date']
    gender=request.form['radio']
    emailid=request.form['textfield2']
    phoneno=request.form['textfield3']
    place=request.form['textfield4']
    post= request.form['textfield5']
    pin = request.form['textfield6']

    department=request.form['select4']
    img.save(static_path+"food\\" + img.filename)
    path = "/static/food/" + img.filename
    password=random.randint(1000,5000)
    qry1="insert into login VALUES (null,'"+emailid+"','"+str(password)+"','"+department+"')"
    res1=db.insert(qry1)
    qry="insert into staff(staff_name,photo,dob,gender,email,place,post,pin,phone,login_id,type )values('"+staffname+"','"+path+"','"+dob+"','"+gender+"','"+emailid+"','"+place+"','"+post+"','"+pin+"','"+phoneno+"','"+str(res1)+"','"+department+"')"
    res = db.insert(qry)
    return adm_add_staff()

@app.route('/adm_view_staff')
def adm_view_staff():
    qr = "select * from staff order by type ASC "
    db=Db()
    res=db.select(qr)
    return render_template("Admin/view staff.html",values=res)

@app.route('/adm_staff_view_more/<id>')
def adm_staff_view_more(id):
    qr = "select * from staff where staff_id='"+str(id)+"' "
    db=Db()
    res=db.selectOne(qr)
    return render_template("Admin/Staff View More.html",values=res)

@app.route('/adm_edit_staff/<fid>')
def adm_edit_staff(fid):
    session['rid'] = fid
    qr ="select * from staff where staff_id='"+str(session['rid'])+"'"
    db = Db()
    res = db.selectOne(qr)

    return render_template("Admin/edit staff.html",values=res)


@app.route('/edit_staff',methods=['post'])
def edit_staff():
    y = session['rid']
    staffname = request.form['textfield']

    dob = request.form['date']
    gender = request.form['radio']
    emailid = request.form['textfield2']
    phoneno = request.form['textfield3']
    department = request.form['select4']
    place = request.form['textfield4']
    post = request.form['textfield5']
    pin = request.form['textfield6']

    qry = "update staff set staff_name='" + staffname + "',dob='" + dob + "',gender='" + gender + "',email='" + emailid + "',place='"+place+"',post='"+post+"',pin='"+pin+"',phone='" + phoneno + "',type='" + department + "' "

    if request.files is not None:
        if 'pic' in request.files:
            img = request.files['pic']
            if img.filename != "":
                img.save(static_path + "food\\" + img.filename)
                path = "/static/food/" + img.filename

                qry = qry + ",photo='" + path + "'"
    else:
        return 'no'
    qry = qry + "where staff_id='"+str(y)+"'"
    res = db.update(qry)
    return adm_view_staff()


@app.route('/adm_delete_staff/<fid>')
def adm_delete_staff(fid):
    qr = "delete from staff where staff_id='"+fid+"'"
    db = Db()
    res = db.delete(qr)
    return adm_view_staff()


@app.route('/adm_add_table')
def adm_add_table():
    return render_template("admin/add table.html")

@app.route('/add_table',methods=['post'])
def add_table():
    num=request.form['table']
    img = request.files['fileField']
    img.save(static_path+"Table\\" + img.filename)
    path = "/static/Table/" + img.filename
    price=request.form['textfield']
    qr1="select * from table_hotel where table_num='"+num+"'"
    res1=db.select(qr1)
    print(res1)
    if len(res1)>0:
        return 'Table Number Existing Already. Enter a New Number'
    else:
        qry = "insert into TABLE_hotel (table_num,picture,charge,status)values('" + num + "','" + path + "','" + price + "','pending')"
        res = db.insert(qry)
        return adm_add_table()






@app.route('/adm_edit_service/<lid>')
def adm_edit_service(lid):
    qry = "select * from service where service_id='"+lid+"'"
    session ['pp']=lid
    res = db.selectOne(qry)
    return render_template("admin/edit service.html",data=res)




@app.route('/adm_edit_special_food_items')
def adm_edit_special_food_items():
    qry = "select * from category"
    res = db.select(qry)
    return render_template("admin/edit special food items.html",data=res)



@app.route('/adm_Manage_Category')
def adm_Manage_Category():
    return render_template("admin/Manage Category.html")

@app.route('/manage_category',methods=['post'])
def manage_category():
    category = request.form['select']
    qry="insert into category (category_name) values ('"+category+"')"
    res = db.insert(qry)
    return adm_Manage_Category()

@app.route('/adm_edit_category/<lid>')
def adm_edit_category(lid):
    qry = "select * from category where category_id='" +lid+ "'"
    res = db.selectOne(qry)
    print(res)
    session ['pp']=lid
    return render_template("admin/Edit Category.html",data=res)

@app.route('/trn_edit_add_category',methods=['post'])
def trn_edit_add_category():
    db=Db()
    y=session['pp']
    category = request.form['select']
    qr = "update category set category_name='" + category + "' where category_id='"+str(y)+"'"
    res = db.update(qr)
    return adm_View_Category()





@app.route('/send_comp/<jk>')
def send_comp(jk):
    session['jk']=jk
    print(jk)
    qry = "select * from complaint where complaint_id='" + jk + "'"
    res = db.selectOne(qry)
    return  render_template("Admin/Send reply.html",data=res)



@app.route('/sendingg',methods=['post'])
def sendingg():
    x=session['jk']
    category = request.form['textarea2']
    qry="update complaint set reply='"+category+"' where complaint_id='"+str(x)+"'"
    res = db.update(qry)
    return adm_View_Complaints()


@app.route('/adm_view_tables')
def adm_view_tables():
    qr = "select * from table_hotel"
    db = Db()
    res = db.select(qr)
    return render_template("admin/view add table.html",values=res)
@app.route('/adm_view_tables_delete/<fid>')
def adm_view_tables_delete(fid):
    qr = "delete from table_hotel where table_hotel_id='"+fid+"'"
    db = Db()
    res = db.delete(qr)
    return adm_view_tables()

@app.route('/adm_edit_table/<id>')
def adm_edit_table(id):
    db=Db()
    qry = "select * from table_hotel where table_hotel_id='"+id+"'"
    res = db.selectOne(qry)
    print(res)
    session['rid'] = id
    return render_template("Admin/edit add table.html",data=res)

@app.route('/adm_edit_add_table',methods=['post'])
def adm_edit_add_table():
    db=Db()
    y = session['rid']
    tabnum = request.form['textfield']

    charge = request.form['textfield1']
    qry="select * from table_hotel where table_num='"+tabnum+"' and table_hotel_id!='"+str(y)+"'"
    res=db.select(qry)
    print(res)
    if len(res)>0:
        return 'Table Number Already Existing'
    else:
        qry="update table_hotel set table_num='"+tabnum+"',charge='"+charge+"' "
        if request.files is not None:
            if 'filefield' in request.files:
                img = request.files['filefield']
                if img.filename != "":
                    img.save(static_path + "Table\\" + img.filename)
                    path = "/static/Table/" + img.filename
                    qry = qry + ",picture='"+path+"'"
        else:
            return 'no'
        qry = qry + " where table_hotel_id='"+str(y)+"'"
        res = db.update(qry)
        return adm_view_tables()




@app.route('/adm_View_Category')
def adm_View_Category():
    qr="select * from category"
    db=Db()
    res=db.select(qr)
    return render_template("admin/View Category.html",values=res)
@app.route('/adm_view_category_delete/<fid>')
def adm_view_category_delete(fid):
    qr = "delete from category where category_id='"+fid+"'"
    db = Db()
    res = db.delete(qr)
    return adm_View_Category()




@app.route('/adm_View_Complaints')
def adm_View_Complaints():
    qr = "select complaint.*,customer.customer_name from customer,complaint where complaint.customer_id=customer.login_id and complaint.reply='pending' and complaint.type='admin'"
    db = Db()
    res = db.select(qr)
    return render_template("admin/View complaints.html", values=res)

@app.route('/adm_View_Feedback')
def adm_View_Feedback():
    qr=db.select("select feedbacks.*,customer.customer_name from customer,feedbacks where feedbacks.customer_id=customer.login_id and `feedbacks`.`type`='admin'")
    return render_template("admin/View Feedback.html",data=qr)

@app.route('/adm_view_food_items')
def adm_view_food_items():
    qr = "select food_items.food_item_id,food_items.food_name,food_items.price,food_items.picture,food_items.description,category.category_name from food_items inner join category on food_items.category_id=category.category_id order by category_name ASC"
    db = Db()
    res = db.select(qr)


    return render_template("admin/view food items.html",values=res)
@app.route('/adm_view_food_items_delete/<fid>')
def adm_view_food_items_delete(fid):
    qr = "delete from food_items where food_item_id='"+fid+"'"
    db = Db()
    res = db.delete(qr)
    return adm_view_food_items()
@app.route('/adm_view_food_items_edit/<fid>')
def adm_view_food_items_edit(fid):
    qr ="select food_items.food_item_id,food_items.food_name,food_items.price,food_items.picture,food_items.description,category.* from food_items inner join category on food_items.category_id=category.category_id where food_items.food_item_id='"+fid+"' "
    db = Db()
    res = db.selectOne(qr)

    qr2 = "select * from category"

    res2 = db.select(qr2)

    return render_template("Admin/edit food items.html",data=res,cat=res2)


@app.route('/update_foods',methods=['post'])
def update_foods():
    fid = request.form['id']
    foodname=request.form['textfield']
    price=request.form['textfield2']
    category=request.form['select']

    desc = request.form["des"]
    if 'pic'in request.files:
        if request.files['pic'].filename!='':
            img = request.files['pic']
            img.save(static_path+"food\\"+img.filename)
            path="/static/food/"+img.filename
            qry="update food_items set food_name='"+foodname+"',price='"+price+"',category_id='"+category+"',picture='"+path+"',description='"+desc+"' where food_item_id='"+fid+"'"
            res=db.update(qry)
        else:
            qry = "update food_items set food_name='" + foodname + "',price='" + price + "',category_id='" + category + "',description='" + desc + "' where food_item_id='" + fid + "'"
            res = db.update(qry)
    else:
        qry = "update food_items set food_name='" + foodname + "',price='" + price + "',category_id='" + category + "',description='" + desc + "' where food_item_id='" + fid + "'"
        res = db.update(qry)
    return adm_view_food_items()



@app.route('/adm_view_payment_report')
def adm_view_payment_report():
    qr = "Select bank.*,customer.customer_name,order_master.total from bank,customer,order_master where bank.customer_id=customer.customer_id=order_master.customer_id "
    db = Db()
    res = db.select(qr)
    return render_template("admin/view payment report.html",values=res)






@app.route('/adm_view_service')
def adm_view_service():
    qr = "select * from service"
    db = Db()
    res = db.select(qr)
    return render_template("admin/view service.html",data=res)

@app.route('/update_service',methods=['post'])
def update_service():
    x=session['pp']
    # fid = request.form['form1']
    name=request.form['textfield']
    description=request.form['textfield2']
    qry="update service set name='"+name+"',description='"+description+"'where service_id='"+str(x)+"'"
    res = db.update(qry)
    return adm_view_service()

@app.route('/adm_delete_service/<lid>')
def adm_delete_service(lid):
    qr = "delete from service where service_id ='"+lid+"'"
    db = Db()
    res = db.delete(qr)
    return adm_view_service()



@app.route('/adm_view_special_food_items')
def adm_view_special_food_items():
    return render_template("admin/view special food items.html")






@app.route('/ManagerHomepage')
def mng_Homepage():
    return render_template("Manager/dashboard.html")

@app.route('/mng_view_order/')
def mng_view_order():
    qr="select order_master_id,customer.customer_name,order_master.total from customer INNER JOIN order_master ON customer.login_id=order_master.customer_id and order_master.status='ok'"
    db = Db()
    res = db.select(qr)
    return render_template("Manager/View Order.html",values=res)
@app.route('/mng_view_tbl/')
def mng_view_ordrrer():
    qr="SELECT table_hotel.table_hotel_id,`table_booking`.`table_book_id`,`customer`.`customer_name`,`customer`.`phone`,`table_booking`.`date`,`table_booking`.`time` FROM `table_hotel`,`table_booking`,`customer` WHERE `customer`.`login_id`=`table_booking`.`cust_id` AND `table_booking`.`table_hotel_id`=`table_hotel`.`table_hotel_id` AND `table_hotel`.status='ok'"
    db = Db()
    res = db.select(qr)
    return render_template("Manager/view_tbl.html",values=res)

@app.route('/mng_accept22/<vid>/<id>')
def mng_accept22(vid,id):
    qr="update table_hotel set status='pending' where table_hotel_id='"+str(id)+"'"
    print(qr)
    db=Db()
    res=db.update(qr)

    qr2 = "delete from table_booking where table_book_id='" + str(vid) + "'"
    print(qr2)
    db = Db()
    db.update(qr2)

    return mng_view_ordrrer()



@app.route('/mng_view_items/<vid>')
def mng_view_items(vid):
    qr="select food_items,quantity from order_table where order_master_id='"+vid+"'"
    db=Db()
    res=db.select(qr)
    return render_template("Manager/View Items.html",values=res)


@app.route('/mng_accept/<vid>')
def mng_accept(vid):
    qr="UPDATE `order_master` SET `status`='approved' where order_master_id='"+vid+"'"
    db=Db()
    res=db.update(qr)
    return mng_view_order()

@app.route('/mng_track_order')
def mng_track_order():

    return render_template("Manager/Track Order.html")

@app.route('/mng_view_complaint')
def mng_view_complaint():
    qr ="SELECT complaint_id,complaint.complaints,`complaint`.`reply`,customer.customer_name,complaint.date FROM complaint INNER JOIN customer ON complaint.customer_id=customer.login_id WHERE `complaint`.`type`='manager'"
    db = Db()
    res = db.select(qr)
    return render_template("Manager/View Complaint.html",values=res)

@app.route('/mng_send_reply/<id>')
def mng_send_reply(id):
    session['rid']=id
    qry = "select * from complaint where complaint_id='"+id+"'"
    res=db.selectOne(qry)
    return  render_template("Manager/Send Reply.html",data=res)

@app.route('/mng_sending_reply',methods=['post'])
def mng_sending_reply():
    y=session['rid']
    reply=request.form['textarea2']
    qr = "update complaint set reply='"+reply+"',date=curdate() where complaint_id='"+str(y)+"'"
    res = db.update(qr)
    return mng_view_complaint()


@app.route('/manager_view_feedback')
def manager_view_feedback():


    qr="SELECT `feedbacks`.*,`customer`.* FROM `customer`,`feedbacks` WHERE `feedbacks`.`customer_id`=`customer`.`login_id` AND `feedbacks`.`type`='manager'"
    db=Db()
    res=db.select(qr)
    return render_template("Manager/Transport View Feedback.html",values=res)



@app.route('/WaitorHomepage')
def wtr_Homepage():
    return render_template("Waitor/wtrdashboard.html")



@app.route('/wtr_view_order/')
def wtr_view_order():
    qr="select order_master_id,customer.customer_name,customer.phone from customer,order_master where customer.login_id=order_master.customer_id and order_master.status='approved' and date=curdate()"
    db = Db()
    res = db.select(qr)
    return render_template("Waitor/Waitor View Order.html",values=res)


@app.route('/wtr_view_items/<vid>')
def wtr_view_items(vid):
    qr="select food_items,quantity,customer.customer_name from order_table,order_master,customer where order_table.order_master_id=order_master.order_master_id and order_master.customer_id=customer.login_id and order_master.status='approved' and order_master.date=curdate() and order_table.order_master_id='"+str(vid)+"'"
    db=Db()
    res=db.select(qr)
    return render_template("Waitor/Waitor View Items.html",values=res)




@app.route('/wtr_view_items_fin/<vid>')
def wtr_view_itemfffs(vid):
    qr="update order_master set status='over' where order_master_id='"+str(vid)+"'"
    db=Db()
    res=db.update(qr)
    return render_template("Waitor/wtrdashboard.html")



@app.route('/BillingHomepage')
def billing_Homepage():

    return render_template("Billing/billdashboard.html")


@app.route('/bill_view_order/')
def bill_view_order():
    qr = "select order_master_id,customer.customer_name,order_master.total,order_master.status from customer INNER JOIN order_master ON customer.login_id=order_master.customer_id where order_master.status='approved'"
    db = Db()
    res = db.select(qr)
    return render_template("Billing/view order.html",values=res)


@app.route('/bill_paid/<rid>',methods=['get'])
def bill_paid(rid):
    qr = "update order_master set status='Paid' where order_master_id='"+rid+"'"
    res = db.update(qr)
    return bill_view_order()


@app.route('/bill_view_items/<iid>')# @app.route('/adm_view_staff')
def bill_view_items(iid):
    qr = "select order_master_id,food_items.food_name,food_items.price,order_table.quantity from food_items Inner join order_table ON food_items.food_item_id=order_table.food_items_id where order_master_id='"+iid+"'"
    db = Db()
    res = db.select(qr)
    return render_template("Billing/view items.html",values=res)

@app.route('/bill_view_payment_history/')
def bill_view_payment_history():
    qr = "SELECT order_master_id,customer.customer_name,order_master.total,order_master.date FROM customer INNER JOIN order_master ON customer.login_id=order_master.customer_id AND `order_master`.`status`='Paid'"
    db = Db()
    res = db.select(qr)
    return render_template("Billing/view payment history.html",values=res)




@app.route('/TransportHomepage')
def transport_Homepage():

    return render_template("Transport/trndashboard.html")

@app.route('/trn_add_vehicle')
def trn_add_vehicle():
    return render_template("Transport/Add Vehicle.html")

@app.route('/add_vehicle',methods=['post'])
def add_vehicle():
    tid=session['id']
    vname=request.form['textfield']
    regno=request.form['textfield2']
    fare=request.form['textfield3']
    qry="insert into vehicle(vehicle_name,reg_no,fare,tid,status)values ('"+vname+"','"+regno+"','"+fare+"','"+str(tid)+"','yes')"
    res=db.insert(qry)
    return trn_add_vehicle()

@app.route('/trn_view_vehicles')
def trn_view_vehicles():
    tid=session['id']
    qr = "SELECT * FROM `vehicle` WHERE `tid`='"+str(tid)+"'"
    db = Db()
    res = db.select(qr)
    return render_template("Transport/View Vehicles.html",data=res)

@app.route('/trn_edit_vehicle/<id>')
def trn_edit_vehicle(id):
    session['rid'] = id
    qry = "select * from vehicle where vehicle_id='"+str(session['rid'])+"'"
    res = db.selectOne(qry)
    print(res)
    return render_template("Transport/Edit Vehicle.html",data=res)

@app.route('/trn_edit_add_vehicle',methods=['post'])
def trn_edit_add_vehicle():
    y=session['rid']
    vname = request.form['textfield']
    regno = request.form['textfield2']
    fare = request.form['textfield3']
    qr = "update vehicle set vehicle_name='"+vname+"', reg_no='"+regno+"', fare='"+fare+"' where vehicle_id='"+str(y)+"'"
    res = db.update(qr)
    return trn_view_vehicles()

@app.route('/trn_vehicle_delete/<fid>')
def trn_vehicle_delete(fid):
    qr = "delete from vehicle where vehicle_id='"+fid+"'"
    db = Db()
    res = db.delete(qr)
    return trn_view_vehicles()

@app.route('/trn_view_booking')
def trn_view_booking():
    qr = "select vehicle_booking.*,vehicle.*,customer.* from vehicle_booking inner join vehicle on vehicle.vehicle_id=vehicle_booking.vehcile_id inner join customer on customer.login_id=vehicle_booking.customer_id where vehicle_booking.status='pending' and vehicle.status='no'"
    db = Db()
    res = db.select(qr)
    return render_template("Transport/View Booking.html",data=res)


@app.route('/booking_approve/<rid>/<id>')
def booking_approve(rid,id):
    qr = "update vehicle_booking set status='Approved' where vehcile_booking_id='"+rid+"'"
    print(qr)
    res = db.update(qr)
    qr2 = "UPDATE `vehicle` SET `status`='yes' WHERE `vehicle_id`='"+str(id)+"'"
    print(qr)
    res = db.update(qr2)

    return trn_view_booking()

@app.route('/booking_reject/<rid>/<id>')
def booking_reject(rid,id):
    qr = "update vehicle_booking set status='Rejected' where vehcile_booking_id='"+rid+"'"
    res = db.update(qr)
    qr2 = "UPDATE `vehicle` SET `status`='yes' WHERE `vehicle_id`='" + str(id) + "'"
    print(qr)
    res = db.update(qr2)

    return trn_view_booking()


@app.route('/trn_view_complaint')
def trn_view_complaint():
    qr ="SELECT `complaint`.*,`customer`.* FROM `complaint`,`customer` WHERE `customer`.`login_id`=`complaint`.`customer_id` AND `complaint`.`type`='transport'"
    db=Db()
    res=db.select(qr)
    return render_template("Transport/Transport View Complaint.html",values=res)

@app.route('/trn_send_reply/<id>')
def trn_send_reply(id):
    session['rid']=id
    qry = "select * from complaint where complaint_id='"+id+"'"
    res=db.selectOne(qry)
    return  render_template("Transport/Transport Send Reply.html",data=res)

@app.route('/trn_sending_reply',methods=['post'])
def trn_sending_reply():
    y=session['rid']
    reply=request.form['textarea2']
    qr = "update complaint set reply='"+reply+"',date=curdate() where complaint_id='"+str(y)+"'"
    res = db.update(qr)
    return trn_view_complaint()

@app.route('/trn_view_feedbacks')
def trn_view_feedbacks():
    # qr = "select feedbacks.*,customer.customer_name,vehicle_booking.vehcile_id from customer,feedbacks,vehicle_booking where customer.login_id=feedbacks.customer_id=vehicle_booking.vehcile_id and type='transport'"


    qr="SELECT `feedbacks`.*,`customer`.* FROM `customer`,`feedbacks` WHERE `feedbacks`.`customer_id`=`customer`.`login_id` AND `feedbacks`.`type`='transport'"
    db=Db()
    res=db.select(qr)
    return render_template("Transport/Transport View Feedback.html",values=res)


# ......................................android service........................................................


@app.route('/and_login_post',methods=["post"])
def and_login_post():
    db=Db()
    db = Db()
    Username=request.form['Email']
    password=request.form['Password']
    qry="select * from login where username='"+Username+"' and password='"+password+"'"
    res=db.selectOne(qry)
    print(res)
    if res!=None:
        qry1="SELECT * FROM `customer` WHERE `login_id`='"+str(res['login_id'])+"'"
        res1=db.selectOne(qry1)
        return jsonify(status="ok",lid=res['login_id'],type=res['type'],uname=res1['customer_name'],usid=res1['customer_id'],usemail=res1['email'])
    else:
        return jsonify(status="no")

@app.route('/customer_reg',methods=["post"])
def customer_reg():
    name=request.form["name"]
    dob = request.form["dob"]
    gen = request.form["gender"]
    phone = request.form["phone"]
    email = request.form["email"]
    place = request.form["place"]
    lmark = request.form["lmark"]
    pass1 = request.form["pass"]
    post = request.form["post"]
    db = Db()

    ser1 = "insert into login (username,password,type) values('" + email + "','" +pass1+ "','customer')"
    res = db.insert(ser1)

    qury = "INSERT INTO `customer`(`customer_name`,`dob`,`gender`,`phone`,`email`,`login_id`,`place`,`landmark`,`post`)VALUES('"+name+"','"+dob+"','"+gen+"','"+phone+"','"+email+"','"+str(res)+"','"+place+"','"+lmark+"','"+post+"')"
    res1 = db.insert(qury)
    return jsonify(status="ok")



@app.route('/send_complaint',methods=['post'])
def send_complient():
    d = Db()
    cid=request.form['cid']
    complaint=request.form['complaint']
    type=request.form['ty']

    qry="INSERT INTO `complaint`(`complaints`,`customer_id`,`date`,`reply`,`type`)VALUES('"+complaint+"','"+str(cid)+"',CURDATE(),'pending','"+type+"')"
    res=d.insert(qry)
    return jsonify(status='ok')


@app.route('/view_complaint_reply',methods=['post'])
def view_complient():
    d = Db()
    cid = request.form['cid']
    type=request.form['ty']
    qry="SELECT * FROM `complaint` WHERE `customer_id`='"+str(cid)+"' AND `type`='"+type+"' order by date "
    res=d.select(qry)
    return jsonify(status='ok',data=res)

@app.route('/send_feed',methods=['post'])
def send_feedback():
    d = Db()
    cid=request.form['cid']
    feedback=request.form['fb']
    type = request.form['ty']
    qry="INSERT INTO `feedbacks`(`feedbacks`,`customer_id`,`date`,`type`)VALUES('"+feedback+"','"+str(cid)+"',CURDATE(),'"+type+"')"
    res=d.insert(qry)
    return jsonify(status='ok')


@app.route('/view_feedback',methods=['post'])
def view_feedback():
    d = Db()
    cid = request.form['cid']
    type=request.form['ty']
    qry="SELECT * FROM `feedbacks` WHERE `feedbacks.`customer_id`='"+str(cid)+"' and `feedbacks`.`type`='"+type+"'"
    print(qry)
    res=d.select(qry)
    print(res)
    return jsonify(status='ok',data=res)


@app.route('/view_vehicle',methods=['post'])
def view_vehicle():
    d = Db()
    qry="SELECT `vehicle`.*,`staff`.* FROM `vehicle`,`staff` WHERE `vehicle`.`tid`=`staff`.`login_id` and vehicle.status='yes'"
    print(qry)
    res=d.select(qry)
    print(res)
    return jsonify(status='ok',data=res)

@app.route('/req_veh',methods=['post'])
def req_vehicle():
    d = Db()
    print("hhh")
    ciid=request.form['cid']
    viid = request.form['vid']
    qry = "insert into vehicle_booking(`customer_id`,`vehcile_id`,`date`,`time`,`status`) values ('" + ciid + "','" + viid + "',curdate(),curtime(),'pending')"
    print(qry)
    res = d.insert(qry)
    qr2 = "UPDATE `vehicle` SET `status`='no' WHERE `vehicle_id`='" + str(viid) + "'"
    print(qr2)
    res = db.update(qr2)

    # print(res)
    return jsonify(status='ok')



@app.route('/view_table',methods=['post'])
def view_table():
    d = Db()
    qry="SELECT * FROM table_hotel where table_hotel.status='pending'"
    print(qry)
    res=d.select(qry)
    print(res)
    return jsonify(status='ok',data=res)


@app.route('/view_user_pro_bank', methods=["post"])
def view_user_pro_bank():
    d = Db()
    print("mr")
    uid = request.form["uid"]
    ac = request.form["ac"]
    pwd = request.form["pwd"]
    prd_pr = request.form["price"]
    tid = request.form["tid"]


    print("mr")
    q = "select amt from bank where login_id='" + str(uid) + "' and ac_no='" + ac + "' and pwd='" + pwd + "'"
    print(q)

    r = d.selectOne(q)
    print("r=", r)
    bnk_blc = int(r["amt"])
    pri = int(prd_pr)
    new_bl = 0
    print("b1=", bnk_blc)
    print("b2=", pri)
    if bnk_blc > pri:
        print("mmm22")
        new_bl = bnk_blc - pri
        print("now ba=", new_bl)

        qq2 = "update bank set amt='" + str(new_bl) + "' where ac_no='" + ac + "' and pwd='" + pwd + "'"
        d.insert(qq2)

        qq25 = "update table_hotel set status='ok' where table_hotel_id='"+str(tid)+"'"
        print("qqq")
        d.insert(qq25)

        qq23 = "INSERT INTO `table_booking`(`table_hotel_id`,`cust_id`,`date`,`time`,`status`)VALUES('"+str(tid)+"','"+str(uid)+"',CURDATE(),CURTIME(),'pending')"
        print("qqq")
        d.insert(qq23)

        new_ot_bl = 0
        qr3 = "select amt from bank where login_id='1'"
        print(qr3)
        rrk = d.selectOne(qr3)
        othr_bl = int(rrk["amt"])
        print("othr=", othr_bl)
        print("pp=", pri)

        new_ot_bl = othr_bl + pri
        qr4 = "update bank set amt='" + str(new_ot_bl) + "' where login_id='1'"
        print(qr4)
        d.update(qr4)



        return jsonify(status="ok")
    else:
        return jsonify(status="no")


@app.route("/and_payment_table",methods=['post'])
def and_payment():

    acc=request.form['acnt']
    val=request.form['mmyy']
    pinno = request.form['pin']
    ccv = request.form['ccv']
    tid=request.form['t_id']
    total=request.form['amnt']
    lid=request.form['custid']

    qry="select * from bank where customer_id='"+lid+"' and card_number='"+acc+"' and valid_thru='"+val+"' and cvv='"+ccv+"' and pin='"+pinno+"'"
    d=Db()
    res=d.selectOne(qry)
    if res is None:
        return jsonify(status="invalid")
    else:
        balance=res['bal']
        session['a']=balance
        if int(balance)<int(total):
            return jsonify(status="insuff")
        else:
            oid=d.insert("insert into `table_booking`(`table_hotel_id`,`cust_id`,`date`,`time`,`status`)values('"+tid+"','"+lid+"',curdate(),curtime(),'alloted')")
            d.update("update bank set bal='"+str(session['a'])+"'-'" + str(total) + "' where bank_id='" + str(res['bank_id']) + "'")
            return jsonify(status="ok")



@app.route('/view_category',methods=['post'])
def view_cat():
    d = Db()
    qry="SELECT * FROM category"
    print(qry)
    res=d.select(qry)
    print(res)
    return jsonify(status='ok',category=res)


@app.route('/view_food',methods=['post'])
def view_food():
    d = Db()
    cato=request.form['cat']
    qry="SELECT `food_items`.*,`category`.* FROM `food_items`,`category` WHERE `food_items`.`category_id`=`category`.`category_id` and `food_items`.`category_id`='"+cato+"' "
    print(qry)
    res=d.select(qry)
    print(res)
    if res is not None:
        return jsonify(status='ok',food=res)
    else:
        return jsonify(status='No Food In This Category')



@app.route('/view_spcl_food',methods=['post'])
def view_spcl_food():
    d = Db()

    from datetime import date
    import calendar
    my_date = date.today()
    ssk = (calendar.day_name[my_date.weekday()])

    qry = "select special_food_id,spl_food_name,price,picture,description,category.category_name,week from spl_food,category where category.category_id=spl_food.category_id and spl_food.week='" + ssk + "'"

    print(qry)
    res=d.select(qry)
    print(res)
    if res is not None:
        return jsonify(status='ok',food=res)
    else:
        return jsonify(status='No Food In This Category')




@app.route('/view_food_all',methods=['post'])
def view_food_all():
    d = Db()
    qry="SELECT `food_items`.*,`category`.* FROM `food_items`,`category` WHERE `food_items`.`category_id`=`category`.`category_id` "
    print(qry)
    res=d.select(qry)
    print(res)
    return jsonify(status='ok',food=res)

@app.route('/view_sts',methods=['post'])
def view_food_wwweeall():
    d = Db()
    cid=request.form["cid"]
    qry="SELECT `vehicle_name`,`reg_no`,`vehicle_booking`.`status` FROM `vehicle_booking`,`vehicle` WHERE `vehicle`.`vehicle_id`=`vehicle_booking`.`vehcile_id` AND `vehicle_booking`.`customer_id`='"+str(cid)+"'"
    print(qry)
    res=d.select(qry)
    print(res)
    return jsonify(status='ok',food=res)


@app.route('/addtocart',methods=['post'])
def addtocart():
    d = Db()
    fid=request.form['fidd']
    qnt=request.form['qnty']
    cid = request.form['cid']
    fname = request.form['fname']
    price = request.form['price']
    ty=request.form["ty"]

    qr = "select * from cart where food_id='" + fid + "' and cust_id='" + cid + "' and type='"+ty+"'"
    re = db.selectOne(qr)

    if re is None:
        qry = "insert into cart(food_id,cust_id,quantity,fname,price,type) values('" + fid + "','" + cid + "','" + qnt + "','"+fname+"','"+str(price)+"','"+ty+"')"
        res = db.insert(qry)
        return jsonify(status="ok")
    else:
        session['q'] = re['quantity']
        qry = "update cart set quantity='"+str(session['q'])+"'+'" + qnt + "' where cart_id='" + str(re['cart_id']) + "'"
        ree = db.update(qry)
        return jsonify(status="ok")

@app.route('/and_view_cart',methods=['post'])
def and_view_cart():
    db=Db()
    print("jjjj")
    ci=request.form['c_id']
    qry="select cart_id,fname,quantity,price,type from cart where cust_id='"+ci+"'"
    res=db.select(qry)
    if res is not None:
        total=0
        for i in res:
            price=int(i['price'])
            qty=int(i['quantity'])
            total=total+(price*qty)
        return jsonify(status="ok",data=res,amt=total)
    else:
        return jsonify(status="no items present")

@app.route('/and_delete_cart',methods=['post'])
def and_delete_cart():
    db=Db()
    cart_id=request.form['cart_id']
    qry="delete from cart where cart_id='"+cart_id+"'"
    print(qry)
    res=db.delete(qry)
    if res>0:
        return jsonify(status="ok")
    else:
        return jsonify(status="cant")

@app.route("/and_payment_food",methods=['post'])
def and_payment_food():

    acc=request.form['acnt']
    val=request.form['mmyy']
    pinno = request.form['pin']
    ccv = request.form['ccv']
    total=request.form['amnt']
    lid=request.form['custid']

    qry="select * from bank where customer_id='"+lid+"' and card_number='"+acc+"' and valid_thru='"+val+"' and cvv='"+ccv+"' and pin='"+pinno+"'"
    d=Db()
    res=d.selectOne(qry)
    if res is None:
        return jsonify(status="invalid")
    else:
        balance = res['bal']
        session['a'] = balance
        if int(balance) < int(total):
            return jsonify(status="insuff")
        else:
            print("ok")
            qry2 = "select * from cart where cust_id='" + lid + "'"
            res2 = d.select(qry2)
            qqq = "select table_hotel_id from table_booking where cust_id='" + lid + "'"
            rrr= d.selectOne(qqq)
            session['ti']=rrr['table_hotel_id']
            oid = d.insert("insert into order_master(`customer_id`,`total`,`date`,`status`,`type`,`table_hotel_id`) values('" + lid + "','"+total+"',curdate(),'success','food','" +str(session['ti'])+ "')")
            for i in res2:
                qry3 = "insert into order_table(`food_items_id`,`quantity`,`order_master_id`) values('" + str(i['food_id']) + "','" + str(i['quantity']) + "','" + str(oid) + "')"
                d.insert(qry3)
                d.delete("delete from cart where cart_id='" + str(i['cart_id']) + "'")
                d.update("update bank set bal='" + str(session['a']) + "'-'" + str(total) + "' where bank_id='" + str(res['bank_id']) + "'")
                return jsonify(status="ok")

@app.route('/and_view_order',methods=['post'])
def and_view_order():
    db=Db()
    cid=request.form['custid']
    print(cid)
    qry="SELECT `order_master`.*,`delay_message`.* FROM `order_master`,`delay_message` WHERE `order_master`.`order_master_id`=`delay_message`.`order_master_id` and customer_id='"+cid+"'  ORDER BY delay_message.date "
    res=db.select(qry)
    if res is not None:
        return jsonify(status="ok",data=res)
    else:
        return jsonify(status="cant")



@app.route('/and_cal_cart',methods=['post'])
def and_cal_cart():
    db=Db()
    print("jjjj")
    cid=request.form['uid']
    print(cid)
    qry="select quantity,price,fname,type from cart where cust_id='"+str(cid)+"'"
    res=db.select(qry)
    if res is not None:
        print("entr")
        ik=0
        for i in res:
            ik=ik+int(i["quantity"])*int(i["price"])

            print(i)
        print("ik=",ik)
        qq2 = "insert into order_master(customer_id,total,date,status)values('"+str(cid)+"','"+str(ik)+"',curdate(),'pending')"
        mms=db.insert(qq2)
        print("mmss=",mms)

        
        for ii in res:
            print("mmm")
            qq2 = "insert into order_table(food_items,quantity,order_master_id,type)values('"+ii["fname"]+"','"+str(ii["quantity"])+"','"+str(mms)+"','"+ii["type"]+"')"
            db.insert(qq2)


        return jsonify(status="ok",data=res,amt=ik)
    else:
        return jsonify(status="cant")

@app.route('/mmm')
def view_ummm():
    return render_template("asd.html")

        
        
@app.route('/view_user_pro_bank2', methods=["post"])
def view_user_pro_bank2():
    d = Db()
    print("mr")
    uid = request.form["uid"]
    ac = request.form["ac"]
    pwd = request.form["pwd"]
    prd_pr = request.form["price"]
   


    print("mr")
    q = "select amt from bank where login_id='" + str(uid) + "' and ac_no='" + ac + "' and pwd='" + pwd + "'"
    print(q)

    r = d.selectOne(q)
    print("r=", r)
    bnk_blc = int(r["amt"])
    pri = int(prd_pr)
    new_bl = 0
    print("b1=", bnk_blc)
    print("b2=", pri)
    if bnk_blc > pri:
        print("mmm22")
        new_bl = bnk_blc - pri
        print("now ba=", new_bl)

        qq2 = "update bank set amt='" + str(new_bl) + "' where ac_no='" + ac + "' and pwd='" + pwd + "'"
        d.insert(qq2)
        
        q11 = "select order_master_id from order_master where customer_id='"+str(uid)+"' and status='pending'"
        print(q11)
        rm= d.selectOne(q11)
        print("rm=",rm)

        
        qq2 = "update order_master set status='ok' where order_master_id='"+str(rm['order_master_id'])+"'"
        print(qq2)
        d.update(qq2)


       

        new_ot_bl = 0
        qr3 = "select amt from bank where login_id='1'"
        print(qr3)
        rrk = d.selectOne(qr3)
        othr_bl = int(rrk["amt"])
        print("othr=", othr_bl)
        print("pp=", pri)

        new_ot_bl = othr_bl + pri
        qr4 = "update bank set amt='" + str(new_ot_bl) + "' where login_id='1'"
        print(qr4)
        d.update(qr4)
        
        qq2 = "delete from cart where cust_id='"+str(uid)+"'"
        d.update(qq2)




        return jsonify(status="ok")
    else:
        return jsonify(status="no")


        

if __name__ == '__main__':
    app.run(debug=True,port=5000,host="0.0.0.0")
