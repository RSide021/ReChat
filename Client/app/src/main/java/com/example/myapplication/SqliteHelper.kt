package com.example.myapplication

import android.content.ContentValues
import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper
import android.util.Log

class SqliteHelper(context: Context) :
        SQLiteOpenHelper(context, DB_NAME, null, DB_VERSION) {

    override fun onCreate(db: SQLiteDatabase?) {
        val tableUsersChat = "CREATE TABLE IF NOT EXISTS $LIST_USERS_CHAT " +
                "($TAG_USER TEXT PRIMARY KEY, " +
                "$NAME_USER TEXT)"
        db?.execSQL(tableUsersChat)
        val tableUsersOnline = "CREATE TABLE IF NOT EXISTS $ONLINE_USERS " +
                "($TAG_USER TEXT PRIMARY KEY, " +
                "$NAME_USER TEXT)"
        db?.execSQL(tableUsersOnline)

        val tableMsgDlg = "CREATE TABLE IF NOT EXISTS $MSGDLGTABLE " +
                "($ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $DIALOG_ID TEXT, $SENDER TEXT, $TYPEMSG TEXT, $TEXTMSG TEXT, $TIMECREATED TEXT)"
        db?.execSQL(tableMsgDlg)

        val tableUserDlg = "CREATE TABLE IF NOT EXISTS $USERDLGTABLE " +
                "($ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $DIALOG_ID TEXT, $TAG_USER TEXT, $ENTEREDTIME TEXT)"
        db?.execSQL(tableUserDlg)


    }


    override fun onUpgrade(db: SQLiteDatabase?, oldVersion: Int, newVersion: Int) {
        db?.execSQL("DROP TABLE IF EXISTS $LIST_USERS_CHAT")
        db?.execSQL("DROP TABLE IF EXISTS $ONLINE_USERS")
        db?.execSQL("DROP TABLE IF EXISTS $MSGDLGTABLE")
        db?.execSQL("DROP TABLE IF EXISTS $USERDLGTABLE")
        onCreate(db)
    }


    fun clearTable(){
        val db = this.writableDatabase
        db.delete(ONLINE_USERS, null,null)
        db.delete(MSGDLGTABLE, null,null)
        db.delete(USERDLGTABLE, null,null)
        db.delete(LIST_USERS_CHAT, null,null)
    }

    fun addUserInOnline(tagId : String, username : String) : Boolean{
        val db = this.writableDatabase
        val values = ContentValues()
        values.put(TAG_USER, tagId)
        values.put(NAME_USER, username)
        val success = db.insert(ONLINE_USERS, null, values)
        db.close()
        Log.d("________InsertedInOnline_________", "$success")
        return (Integer.parseInt("$success") != -1)
    }
    fun getAllUsersOnline() : MutableList<Pair<String, String>>{
        val allUser = mutableListOf<Pair<String, String>>()
        val db = readableDatabase
        val selectALLQuery = "SELECT * FROM $ONLINE_USERS"
        val cursor = db.rawQuery(selectALLQuery, null)
        if (cursor != null) {
            if (cursor.moveToFirst()) {
                do {
                    val idTag = cursor.getString(cursor.getColumnIndex(TAG_USER))
                    val nameuser = cursor.getString(cursor.getColumnIndex(NAME_USER))
                    allUser.add(idTag to nameuser)
                } while (cursor.moveToNext())
            }
        }
        cursor.close()
        db.close()
        return allUser
    }
    fun deleteUserFromOnline(tag: String) : Boolean{
        val db = this.writableDatabase
        val success = db.delete(ONLINE_USERS, "$TAG_USER = ?", arrayOf(tag))
        db.close()
        Log.d("________DeletedUsersOnline_________", "$success")
        return (Integer.parseInt("$success") != -1)
    }

    fun deleteUserChat(tag: String) : Boolean{
        val db = this.writableDatabase
        val success = db.delete(LIST_USERS_CHAT, "$TAG_USER = ?", arrayOf(tag))
        db.close()
        Log.d("________DeletedUsersChat_________", "$success")
        return (Integer.parseInt("$success") != -1)
    }

    fun addUserInChat(user: Pair<String, String>): Boolean {
        //Create and/or open a database that will be used for reading and writing.
        val db = this.writableDatabase
        val values = ContentValues()
        values.put(TAG_USER, user.first)
        values.put(NAME_USER, user.second)
        val success = db.insert(LIST_USERS_CHAT, null, values)
        db.close()
        Log.d("________InsertedInChat_________", "$success")
        return (Integer.parseInt("$success") != -1)
    }
    fun checkUserInChat(tagUser : String) : Boolean{
        val db = this.readableDatabase
        val selectQuery = "SELECT * FROM $LIST_USERS_CHAT WHERE $TAG_USER = '$tagUser'"
        val cursor = db.rawQuery(selectQuery, null)
        if(cursor != null){
            if (cursor.moveToFirst()) {
                cursor.close()
                db.close()
                return true
            }
        }
        cursor.close()
        db.close()
        return false
    }
    fun getNameInUserChat(tagUser: String) : String{
        var name = ""
        val db = this.readableDatabase
        val selectQuery = "SELECT $NAME_USER FROM $LIST_USERS_CHAT WHERE $TAG_USER = '$tagUser'"
        val cursor = db.rawQuery(selectQuery, null)
        if(cursor != null){
            if (cursor.moveToFirst()) {
                do {
                    name = cursor.getString(cursor.getColumnIndex(NAME_USER))
                } while (cursor.moveToNext())
            }
        }
        cursor.close()
        db.close()
        return name
    }
    fun checkExistChatWithUser(ourTag : String, tagUser : String ) : Boolean{
        val dialogId1 : String = "$CHAT$tagUser::$ourTag"
        val dialogId2 : String = "$CHAT$ourTag::$tagUser"
        val db = this.readableDatabase
        val selectQuery = "SELECT * FROM $USERDLGTABLE WHERE $DIALOG_ID = '$dialogId1' OR $DIALOG_ID = '$dialogId2'"
        val cursor = db.rawQuery(selectQuery, null)
        if(cursor != null){
            if (cursor.moveToFirst()) {
                cursor.close()
                db.close()
                return true
            }
        }
        cursor.close()
        db.close()
        return false
    }

    fun getDialogIdWithUser(tagUser: String) : String{
        var dialogId : String = ""
        val db = this.readableDatabase
        val selectQuery = "SELECT * FROM $USERDLGTABLE WHERE $TAG_USER = '$tagUser'"
        val cursor = db.rawQuery(selectQuery, null)
        if(cursor != null){
            if (cursor.moveToFirst()) {
                do {
                    dialogId = cursor.getString(cursor.getColumnIndex(DIALOG_ID))
                    if(dialogId.substringBefore("#") == "CHAT"
                            || dialogId.substringBefore("#") == "GROUP") break
                } while (cursor.moveToNext())
            }
        }
        cursor.close()
        db.close()
        return dialogId
    }

    //get all users
    fun getAllUsersChat(): MutableList<Pair<String,String>>{
        val allUser = mutableListOf<Pair<String, String>>()
        val db = readableDatabase
        val selectALLQuery = "SELECT * FROM $LIST_USERS_CHAT"
        val cursor = db.rawQuery(selectALLQuery, null)
        if (cursor != null) {
            if (cursor.moveToFirst()) {
                do {
                    val idTag = cursor.getString(cursor.getColumnIndex(TAG_USER))
                    val nameuser = cursor.getString(cursor.getColumnIndex(NAME_USER))
                    allUser.add(idTag to nameuser)
                } while (cursor.moveToNext())
            }
        }
        cursor.close()
        db.close()
        return allUser
    }


    fun addMsgInTable(dialogID : String, sender : String, typeMsg : String, text : String, timecreated : String ) : Boolean{
        val db = this.writableDatabase
        val values = ContentValues()
        values.put(DIALOG_ID, dialogID)
        values.put(SENDER, sender)
        values.put(TYPEMSG, typeMsg)
        values.put(TEXTMSG, text)
        values.put(TIMECREATED, timecreated)
        val success = db.insert(MSGDLGTABLE, null, values)
        db.close()
        Log.d("________InsertedInTblMsg_________", "$success")
        return (Integer.parseInt("$success") != -1)
    }

    fun getMsgWithUser(dialogID : String) : MutableList<Array<String>>{
        val allMsg = mutableListOf<Array<String>>()
        val db = readableDatabase
        val selectALLQuery = "SELECT * FROM $MSGDLGTABLE WHERE $DIALOG_ID = '$dialogID' ORDER BY $TIMECREATED"
        val cursor = db.rawQuery(selectALLQuery, null)
        if (cursor != null) {
            if (cursor.moveToFirst()) {
                do {
                    val text = cursor.getString(cursor.getColumnIndex(TEXTMSG))
                    val sender = cursor.getString(cursor.getColumnIndex(SENDER))
                    val timeCreated = cursor.getString(cursor.getColumnIndex(TIMECREATED))
                    allMsg.add(arrayOf(sender, text, timeCreated))
                } while (cursor.moveToNext())
            }
        }
        cursor.close()
        db.close()
        return allMsg
    }
    fun qq() : MutableList<Array<String>>{
        val allMsg = mutableListOf<Array<String>>()
        val db = readableDatabase
        val selectALLQuery = "SELECT * FROM $USERDLGTABLE"
        val cursor = db.rawQuery(selectALLQuery, null)
        if (cursor != null) {
            if (cursor.moveToFirst()) {
                do {
                    val dialog_id = cursor.getString(cursor.getColumnIndex(DIALOG_ID))
                    val tagUser = cursor.getString(cursor.getColumnIndex(TAG_USER))
                    val timeCreated = cursor.getString(cursor.getColumnIndex(TIMECREATED))
                    allMsg.add(arrayOf(dialog_id, tagUser, timeCreated))
                } while (cursor.moveToNext())
            }
        }
        cursor.close()
        db.close()
        return allMsg
    }

    fun addUserInDLG(dialogID : String, tagUser : String,  enteredTime : String ) : Boolean{
        val db = this.writableDatabase
        val values = ContentValues()
        values.put(DIALOG_ID, dialogID)
        values.put(TAG_USER, tagUser)
        values.put(ENTEREDTIME, enteredTime)
        val success = db.insert(USERDLGTABLE, null, values)
        db.close()
        Log.d("________InsertedInTblMsg_________", "$success")
        return (Integer.parseInt("$success") != -1)
    }

    fun getAllDlgFromDLG(): MutableList<String>{
        var allDlg : MutableList<String> = mutableListOf()
        val db = readableDatabase
        val selectALLQuery = "SELECT * FROM $USERDLGTABLE"
        val cursor = db.rawQuery(selectALLQuery, null)
        if (cursor != null) {
            if (cursor.moveToFirst()) {
                do {
                    val dialog_id = cursor.getString(cursor.getColumnIndex(DIALOG_ID))
                    allDlg.add(dialog_id)
                } while (cursor.moveToNext())
            }
        }
        cursor.close()
        db.close()
        return allDlg
    }


    fun getCountMsgDlg() :  String{
        val db = this.readableDatabase
        val selectQuery = "SELECT $DIALOG_ID FROM $USERDLGTABLE"
        val cursor = db.rawQuery(selectQuery, null)
        if(cursor != null){
            if (cursor.moveToFirst()) {
                do {
                    return cursor.getString(cursor.getColumnIndex(DIALOG_ID))
                } while (cursor.moveToNext())
            }
        }
        cursor.close()
        db.close()
        return ""
    }

    companion object {
        private val DB_NAME = "UserChat"
        private val DB_VERSION = 1;

        private val ONLINE_USERS = "OnlineUsers" // tablename
        private val TAG_USER = "Tag_Of_User" // field in table
        private val NAME_USER = "Name_Of_User" // field in table

        private val LIST_USERS_CHAT = "ListUsersChat" // tablename

        private val MSGDLGTABLE = "MsgDlgTable" // tablename
        private val ID = "id" // field in table
        private val DIALOG_ID = "dialog_id" // field in table (tag of users)
        private val TEXTMSG = "textMsg" // field in table (text of message)
        private val TYPEMSG = "typeMsg"
        private val TIMECREATED = "timecreated" // field in table (time message)
        private val SENDER = "sender" // field in table (who is sender?)

        private val USERDLGTABLE = "UserDlgTable" // tablename
        private val ENTEREDTIME = "EnteredTime"


        private val CHAT = "CHAT#"

    }
}