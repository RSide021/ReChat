package com.example.myapplication.ui

import android.app.AlertDialog
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import com.example.myapplication.ChatPeople
import com.example.myapplication.ActivityMain.Companion.sqliteHelper
import com.example.myapplication.adapters.MyAdapterForChat
import com.example.myapplication.R
import com.google.android.material.floatingactionbutton.FloatingActionButton


class ChatFragment : Fragment(),
    SharedPreferences.OnSharedPreferenceChangeListener{

    internal interface OnFragmentSendDataListener {
        fun onChatLoadView()
        fun onCreateNewDialog()
    }

    companion object{
        fun newInstance() = ChatFragment()
    }

    private var fragmentSendDataListener: OnFragmentSendDataListener? = null
    private lateinit var sp : SharedPreferences

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
            return inflater.inflate(R.layout.fragment_chat, container, false)
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        fragmentSendDataListener = context as OnFragmentSendDataListener
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        sp = requireActivity().getSharedPreferences("OURINFO", Context.MODE_PRIVATE)
        sp.registerOnSharedPreferenceChangeListener(this)
        val listViewChat = requireView().findViewById<ListView>(R.id.listViewChat)
        listViewChat.onItemClickListener = AdapterView.OnItemClickListener { parent, view, position, id ->
            val intent = Intent(activity, ChatPeople::class.java);
            val idUser = view.findViewById<TextView>(R.id.idUser)
            val nameOfUser = view.findViewById<TextView>(R.id.userName)
            val countNewMsgView = view.findViewById<TextView>(R.id.countNewMsg)
            intent.putExtra("idTag", idUser.text)
            intent.putExtra("nameOfUser", nameOfUser.text)
            intent.putExtra("countNewMsg", countNewMsgView.text)
            startActivity(intent)
        }
        listViewChat.onItemLongClickListener = AdapterView.OnItemLongClickListener { parent, view, position, id ->
//            val builder = AlertDialog.Builder(activity)
//            val dialogInflater = this.layoutInflater
//            val dialogView  = dialogInflater.inflate(R.layout.dialog_actions_with_chatchannel, null)
//            val idUser = view.findViewById<TextView>(R.id.idUser)
//            builder.setView(dialogView)
//            val alertDialog = builder.create();
//            alertDialog.show()
//            dialogView.findViewById<Button>(R.id.delThisChat).setOnClickListener(){
//                sqliteHelper.deleteUserChat(idUser.text.toString())
//                alertDialog.dismiss()
//            }
            return@OnItemLongClickListener true
        }
        val fab = requireView().findViewById<FloatingActionButton>(R.id.fab)
        fab.setOnClickListener {
            fragmentSendDataListener?.onCreateNewDialog()
        }
    }
    fun setUserData(myAdapterForChat: MyAdapterForChat){
        val listViewChat = requireView().findViewById<ListView>(R.id.listViewChat)
        listViewChat.adapter = myAdapterForChat
    }

    override fun onStart() {
        super.onStart()
        fragmentSendDataListener?.onChatLoadView()
    }

    override fun onSharedPreferenceChanged(sharedPreferences: SharedPreferences?, key: String?) {
        if(this.isVisible){
            if(key.equals("changeUserDlg")){
                fragmentSendDataListener?.onChatLoadView()
            }
        }
    }
}